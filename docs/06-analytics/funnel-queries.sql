-- Onboarding v2 — Funnel query templates
--
-- Companion to event-taxonomy.md and instrumentation-contract.md.
-- All queries run against `public.events` and `public.funnel_sessions`
-- (defined in db/supabase/006_onboarding_v2.sql).
--
-- Run via Supabase SQL editor (admin/service-role). Queries return
-- one row per metric — wire to a BI dashboard or Postgres function
-- for self-serve analytics later.

-- =========================================================================
-- 1. Step-by-step funnel conversion
-- =========================================================================
-- Returns: count of users at each step / count at previous step.
-- Window: last 30 days. Adjust DATE_TRUNC as needed.

WITH step_users AS (
  SELECT
    event_name,
    COUNT(DISTINCT user_id) FILTER (WHERE user_id IS NOT NULL)
      + COUNT(DISTINCT session_id) FILTER (WHERE user_id IS NULL) AS users
  FROM public.events
  WHERE occurred_at >= NOW() - INTERVAL '30 days'
    AND event_name IN (
      'welcome_viewed',
      'signup_method_picker_viewed',
      'signup_completed',
      'phase2_step1_viewed',
      'phase2_completed',
      'phase3_viewed',
      'phase3_completed',
      'phase4_step1_viewed',
      'phase4_completed',
      'phase5_step1_viewed',
      'phase5_completed',
      'phase6_step1_viewed',
      'phase6_completed',
      'phase7_started',
      'phase7_completed',
      'phase8_dashboard_viewed'  -- north star
    )
  GROUP BY event_name
)
SELECT
  event_name AS step,
  users,
  ROUND(100.0 * users / NULLIF(LAG(users) OVER (ORDER BY users DESC), 0), 1) AS step_conversion_pct,
  ROUND(100.0 * users / FIRST_VALUE(users) OVER (ORDER BY users DESC), 1) AS cumulative_pct
FROM step_users
ORDER BY users DESC;

-- =========================================================================
-- 2. Drop-off heatmap by step
-- =========================================================================
-- Returns: which step has highest abandonment (users who reached this
-- step but never reached the next one).

WITH session_progress AS (
  SELECT
    session_id,
    MAX(phase) AS max_phase,
    MAX(occurred_at) AS last_event_at,
    COUNT(*) AS event_count
  FROM public.events
  WHERE occurred_at >= NOW() - INTERVAL '30 days'
  GROUP BY session_id
)
SELECT
  max_phase,
  COUNT(*) AS sessions_stuck_here,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
FROM session_progress
WHERE last_event_at < NOW() - INTERVAL '30 minutes'  -- considered abandoned
GROUP BY max_phase
ORDER BY max_phase;

-- =========================================================================
-- 3. Time-to-complete per step (median, p90)
-- =========================================================================
-- Returns: how long users typically spend in each phase.

WITH phase_times AS (
  SELECT
    session_id,
    phase,
    MIN(occurred_at) AS phase_started,
    MAX(occurred_at) AS phase_ended,
    EXTRACT(EPOCH FROM (MAX(occurred_at) - MIN(occurred_at))) AS seconds_in_phase
  FROM public.events
  WHERE occurred_at >= NOW() - INTERVAL '30 days'
    AND phase IS NOT NULL
  GROUP BY session_id, phase
  HAVING EXTRACT(EPOCH FROM (MAX(occurred_at) - MIN(occurred_at))) BETWEEN 1 AND 1800
)
SELECT
  phase,
  COUNT(*) AS samples,
  ROUND(percentile_cont(0.5) WITHIN GROUP (ORDER BY seconds_in_phase)::numeric, 1) AS median_s,
  ROUND(percentile_cont(0.9) WITHIN GROUP (ORDER BY seconds_in_phase)::numeric, 1) AS p90_s
FROM phase_times
GROUP BY phase
ORDER BY phase;

-- =========================================================================
-- 4. Cohort retention by signup method (validates H11)
-- =========================================================================
-- Returns: D1, D7, D30 retention grouped by signup method.

WITH cohorts AS (
  SELECT
    user_id,
    properties->>'method' AS signup_method,
    DATE(occurred_at) AS signup_date
  FROM public.events
  WHERE event_name = 'signup_completed'
    AND occurred_at >= NOW() - INTERVAL '60 days'
),
returns AS (
  SELECT DISTINCT user_id, DATE(occurred_at) AS active_date
  FROM public.events
  WHERE occurred_at >= NOW() - INTERVAL '60 days'
)
SELECT
  c.signup_method,
  COUNT(DISTINCT c.user_id) AS cohort_size,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN r.active_date = c.signup_date + INTERVAL '1 day' THEN c.user_id END)
        / COUNT(DISTINCT c.user_id), 1) AS d1_retention_pct,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN r.active_date = c.signup_date + INTERVAL '7 days' THEN c.user_id END)
        / COUNT(DISTINCT c.user_id), 1) AS d7_retention_pct,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN r.active_date = c.signup_date + INTERVAL '30 days' THEN c.user_id END)
        / COUNT(DISTINCT c.user_id), 1) AS d30_retention_pct
FROM cohorts c
LEFT JOIN returns r ON r.user_id = c.user_id
GROUP BY c.signup_method
ORDER BY cohort_size DESC;

-- =========================================================================
-- 5. Goal-completion rate vs no-goal users (validates H2 + H6)
-- =========================================================================
-- Compares users who finished Phase 5.2 with 2 goals vs users who exited
-- before completing goals. Looks at "goal contribution made" within 90 days
-- as the validation signal.

WITH goal_completers AS (
  SELECT DISTINCT user_id
  FROM public.events
  WHERE event_name = 'phase5_step2_completed'
    AND occurred_at >= NOW() - INTERVAL '90 days'
    AND user_id IS NOT NULL
),
goal_skippers AS (
  SELECT DISTINCT user_id
  FROM public.events
  WHERE event_name IN ('phase5_step1_viewed', 'phase5_step2_viewed')
    AND occurred_at >= NOW() - INTERVAL '90 days'
    AND user_id IS NOT NULL
    AND user_id NOT IN (SELECT user_id FROM goal_completers)
),
contributions AS (
  SELECT DISTINCT user_id
  FROM public.events
  WHERE event_name = 'goal_contribution_made'  -- post-onboarding event from existing wire-through
    AND occurred_at >= NOW() - INTERVAL '90 days'
)
SELECT
  'completed_2_goals' AS cohort,
  COUNT(DISTINCT gc.user_id) AS cohort_size,
  COUNT(DISTINCT c.user_id) AS contributed_within_90d,
  ROUND(100.0 * COUNT(DISTINCT c.user_id) / NULLIF(COUNT(DISTINCT gc.user_id), 0), 1) AS contribution_pct
FROM goal_completers gc
LEFT JOIN contributions c ON c.user_id = gc.user_id
UNION ALL
SELECT
  'skipped_goals',
  COUNT(DISTINCT gs.user_id),
  COUNT(DISTINCT c.user_id),
  ROUND(100.0 * COUNT(DISTINCT c.user_id) / NULLIF(COUNT(DISTINCT gs.user_id), 0), 1)
FROM goal_skippers gs
LEFT JOIN contributions c ON c.user_id = gs.user_id;

-- =========================================================================
-- 6. SMS permission grant rate (validates H3)
-- =========================================================================

SELECT
  COUNT(DISTINCT CASE WHEN event_name = 'phase3_sms_grant' THEN user_id END) AS granted,
  COUNT(DISTINCT CASE WHEN event_name = 'phase3_sms_skip' THEN user_id END) AS skipped,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN event_name = 'phase3_sms_grant' THEN user_id END)
        / NULLIF(COUNT(DISTINCT CASE WHEN event_name IN ('phase3_sms_grant', 'phase3_sms_skip') THEN user_id END), 0), 1) AS grant_rate_pct
FROM public.events
WHERE occurred_at >= NOW() - INTERVAL '30 days'
  AND event_name IN ('phase3_sms_grant', 'phase3_sms_skip');

-- =========================================================================
-- 7. IP-region pre-detection accuracy (validates H1)
-- =========================================================================
-- Compares phase2_step1_completed rate when prefilled=true vs false.

SELECT
  (properties->>'prefilled')::boolean AS prefilled,
  COUNT(*) AS sessions_started,
  COUNT(*) FILTER (WHERE event_name = 'phase2_step1_completed') AS sessions_completed,
  ROUND(100.0 * COUNT(*) FILTER (WHERE event_name = 'phase2_step1_completed')
        / NULLIF(COUNT(*) FILTER (WHERE event_name = 'phase2_step1_viewed'), 0), 1) AS completion_pct
FROM public.events
WHERE occurred_at >= NOW() - INTERVAL '30 days'
  AND event_name IN ('phase2_step1_viewed', 'phase2_step1_completed')
GROUP BY (properties->>'prefilled')::boolean;

-- =========================================================================
-- 8. Phase 7 backgrounding rate (validates H7)
-- =========================================================================

SELECT
  COUNT(DISTINCT CASE WHEN event_name = 'phase7_started' THEN session_id END) AS started,
  COUNT(DISTINCT CASE WHEN event_name = 'app_backgrounded_during_phase7' THEN session_id END) AS backgrounded,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN event_name = 'app_backgrounded_during_phase7' THEN session_id END)
        / NULLIF(COUNT(DISTINCT CASE WHEN event_name = 'phase7_started' THEN session_id END), 0), 1) AS backgrounded_pct
FROM public.events
WHERE occurred_at >= NOW() - INTERVAL '30 days';

-- =========================================================================
-- 9. State persistence resume rate (validates H10)
-- =========================================================================

WITH abandoned_sessions AS (
  SELECT session_id, MIN(occurred_at) AS first_event
  FROM public.events
  WHERE occurred_at >= NOW() - INTERVAL '30 days'
  GROUP BY session_id
  HAVING MAX(occurred_at) < NOW() - INTERVAL '30 minutes'
    AND NOT EXISTS (
      SELECT 1 FROM public.events e2
      WHERE e2.session_id = public.events.session_id
        AND e2.event_name = 'phase8_dashboard_viewed'
    )
)
SELECT
  COUNT(*) AS abandoned_sessions,
  COUNT(*) FILTER (WHERE EXISTS (
    SELECT 1 FROM public.events e
    WHERE e.session_id = abandoned_sessions.session_id
      AND e.event_name = 'onboarding_resumed'
      AND e.occurred_at BETWEEN abandoned_sessions.first_event AND abandoned_sessions.first_event + INTERVAL '24 hours'
  )) AS resumed_within_24h,
  ROUND(100.0 * COUNT(*) FILTER (WHERE EXISTS (
    SELECT 1 FROM public.events e
    WHERE e.session_id = abandoned_sessions.session_id
      AND e.event_name = 'onboarding_resumed'
      AND e.occurred_at BETWEEN abandoned_sessions.first_event AND abandoned_sessions.first_event + INTERVAL '24 hours'
  )) / NULLIF(COUNT(*), 0), 1) AS resume_rate_pct
FROM abandoned_sessions;

-- =========================================================================
-- 10. Per-persona dashboard contract validation
-- =========================================================================
-- Asserts that each persona's expected widget set actually rendered.
-- Stage 7's integration tests will use this query against synthetic data.

SELECT
  user_id,
  properties->>'persona_signature' AS persona,
  properties->>'has_investments' AS has_investments,
  properties->>'has_remittance' AS has_remittance,
  properties->>'accounts_deferred' AS accounts_deferred,
  (properties->>'widget_count')::int AS widget_count
FROM public.events
WHERE event_name = 'phase8_dashboard_viewed'
  AND occurred_at >= NOW() - INTERVAL '30 days'
ORDER BY occurred_at DESC
LIMIT 100;

-- =========================================================================
-- 11. North-star metric: install → Phase 8 conversion
-- =========================================================================

WITH north_star AS (
  SELECT
    DATE(occurred_at) AS day,
    COUNT(DISTINCT session_id) FILTER (WHERE event_name = 'welcome_viewed') AS installs,
    COUNT(DISTINCT session_id) FILTER (WHERE event_name = 'phase8_dashboard_viewed') AS reached_dashboard
  FROM public.events
  WHERE occurred_at >= NOW() - INTERVAL '30 days'
  GROUP BY DATE(occurred_at)
)
SELECT
  day,
  installs,
  reached_dashboard,
  ROUND(100.0 * reached_dashboard / NULLIF(installs, 0), 1) AS conversion_pct
FROM north_star
ORDER BY day DESC;

-- =========================================================================
-- 12. Funnel session abandoned-step distribution
-- =========================================================================
-- Shows which step (text) is the most common abandonment point.

SELECT
  abandoned_step,
  COUNT(*) AS abandonments,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_of_abandons
FROM public.funnel_sessions
WHERE abandoned_at IS NOT NULL
  AND abandoned_at >= NOW() - INTERVAL '30 days'
GROUP BY abandoned_step
ORDER BY abandonments DESC;

-- =========================================================================
-- Future: wrap each query in a Postgres function for /v1/funnel/* endpoints
-- =========================================================================
-- Stage 7 will create:
--   CREATE FUNCTION get_funnel_metrics(date_range INTERVAL) RETURNS ...
--   CREATE FUNCTION get_dropoff_by_step(date_range INTERVAL) RETURNS ...
-- These are called from NestJS admin controllers (auth required).
