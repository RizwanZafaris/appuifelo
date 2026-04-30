class StitchScreenSpec {
  const StitchScreenSpec(this.id);

  final String id;

  String get title => id
      .replaceAll('.png', '')
      .split('_')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');

  String get availabilityRoute => '/design-screens/$id';

  String? get implementationRoute => stitchImplementationRouteFor(id);

  bool get hasDirectImplementation => implementationRoute != null;
}

const stitchScreenIds = <String>[
  'action_plan',
  'activity_1',
  'activity_2',
  'add_custom_category',
  'add_holding_crypto_form',
  'add_holding_manual_abroad_form',
  'add_holding_picker',
  'add_holding_stock_etf_form',
  'add_to_wallet',
  'address',
  'age_verification',
  'allocation_insights',
  'ask_a_question',
  'auto_pay_setup',
  'bill_detail',
  'bill_new',
  'bill_notification_mock',
  'bill_pay_now',
  'bills_empty_state',
  'bills_list',
  'budget',
  'budget_overview_minimalist_style_1',
  'budget_overview_minimalist_style_2',
  'budget_overview_minimalist_style_3',
  'budget_overview_predictive_style',
  'budget_overview_radial_style',
  'bulk_actions_sheet',
  'capture_receipt_camera',
  'capture_receipt_review_edit',
  'card_controls',
  'card_ready',
  'card_reveal_details',
  'card_settings_close',
  'card_top_up',
  'category_details',
  'category_picker_sheet',
  'check_your_email',
  'choose_split_method',
  'coach_landing',
  'coach_learning',
  'coach_waitlist',
  'connect_brokerage_picker',
  'connected_accounts',
  'create_account',
  'create_card_personalize',
  'create_card_processing',
  'currency',
  'custom_amounts',
  'dashboard_1',
  'dashboard_2',
  'dashboard_3',
  'dashboard_4',
  'date_of_birth',
  'display_language',
  'duplicate_detection_sheet',
  'empty_home',
  'enable_biometrics',
  'equal_split_confirmation',
  'expense_detail',
  'expense_filters_search',
  'expenses_dashboard',
  'expenses_empty_state',
  'expenses_insights',
  'export_expenses_sheet',
  'felo_card_home',
  'felo_financial_management_app',
  'felo_home_dashboard_balance_archetype',
  'felo_home_dashboard_ltr_dark',
  'felo_home_dashboard_rtl_light_1',
  'felo_home_dashboard_rtl_light_10',
  'felo_home_dashboard_rtl_light_11',
  'felo_home_dashboard_rtl_light_2',
  'felo_home_dashboard_rtl_light_3',
  'felo_home_dashboard_rtl_light_4',
  'felo_home_dashboard_rtl_light_5',
  'felo_home_dashboard_rtl_light_6',
  'felo_home_dashboard_rtl_light_7',
  'felo_home_dashboard_rtl_light_8',
  'felo_home_dashboard_rtl_light_9',
  'felo_investments_empty_rtl_dark',
  'felo_investments_portfolio_light',
  'felo_savings_home_bengali_dark',
  'felo_savings_home_ltr_light',
  'freeze_unfreeze',
  'goal_complete',
  'goal_contribute',
  'goal_detail',
  'goal_new_step_1',
  'goal_new_step_2',
  'goal_withdraw',
  'goals_empty_state',
  'goals_list',
  'help_support',
  'help_support_legal',
  'holding_detail',
  'home_dashboard_1',
  'home_dashboard_2',
  'home_dashboard_3',
  'home_dashboard_4',
  'home_dashboard_5',
  'id_capture',
  'image.png_1',
  'image.png_2',
  'intent',
  'investment_activity_net_worth',
  'investment_tracker_variants',
  'investments_dashboard',
  'investments_empty_state',
  'kyc_intro',
  'kyc_status_pending',
  'languages',
  'legal_information',
  'legal_name',
  'link_account_picker',
  'link_connecting',
  'link_failure',
  'link_success',
  'manual_expense_quick_form',
  'merchant_details',
  'minimalist_dashboard_clean_style',
  'minimalist_dashboard_sleek_style',
  'monthly_insights',
  'notifications',
  'notifications_preferences',
  'nudge_reminder_sheet',
  'page_not_found',
  'participant_flow_pay_confirmation',
  'payment_methods',
  'personal_info',
  'pick_participants',
  'premium_cancel',
  'premium_manage',
  'premium_upsell',
  'profile',
  'profile_root',
  'receipt_scan_low_quality_warning',
  'receipt_scan_multi_page_stitching',
  'recipient_details',
  'recipient_edit',
  'recipient_new',
  'recipients',
  'referrals_rewards',
  'replace_card',
  'review_send_message',
  'review_submit',
  'security_overview',
  'security_settings',
  'selfie',
  'send_amount',
  'send_authorizing',
  'send_failure',
  'send_money',
  'send_recipient_select',
  'send_review',
  'send_success',
  'set_budget',
  'shares_percentages',
  'sign_in',
  'spend_overview',
  'spending_insight',
  'split_an_expense_banner',
  'split_complete',
  'split_detail_tracking',
  'split_entry_point',
  'split_variants_remittance_goals',
  'statement_import_success',
  'statement_upload_password_protected',
  'statement_upload_unsupported_format',
  'transaction_detail_1',
  'transaction_detail_2',
  'transfer_tracking',
  'trusted_devices',
  'upgrade_to_physical_card',
  'upload_statement_parsing',
  'upload_statement_picker_1',
  'upload_statement_picker_2',
  'upload_statement_review_transactions',
  'verification_id',
  'verify_phone',
  'virtual_card_intro_1',
  'virtual_card_intro_2',
  'weekly_check_in',
  'welcome_to_felo_1',
  'welcome_to_felo_2',
];

final stitchScreenSpecs = stitchScreenIds
    .map((id) => StitchScreenSpec(id))
    .toList(growable: false);

StitchScreenSpec? stitchScreenById(String id) {
  for (final spec in stitchScreenSpecs) {
    if (spec.id == id) {
      return spec;
    }
  }
  return null;
}

String? stitchImplementationRouteFor(String id) {
  if (_containsAny(id, ['home', 'dashboard', 'empty_home', 'savings_home'])) {
    return '/home';
  }
  if (_containsAny(id, ['activity', 'transaction', 'expense', 'spend'])) {
    return '/transactions';
  }
  if (_containsAny(id, ['budget', 'category'])) {
    return '/budgets';
  }
  if (_containsAny(id, ['goal'])) {
    return '/goals';
  }
  if (_containsAny(id, ['coach', 'question', 'action_plan', 'weekly'])) {
    return '/coach';
  }
  if (_containsAny(id, ['bill', 'auto_pay'])) {
    return '/bills';
  }
  if (_containsAny(id, ['send', 'recipient', 'transfer', 'split'])) {
    return '/send';
  }
  if (_containsAny(id, ['account', 'link_', 'connected', 'brokerage'])) {
    return '/accounts';
  }
  if (_containsAny(id, ['receipt', 'statement_upload'])) {
    return '/transactions';
  }
  if (_containsAny(id, ['kyc', 'id_', 'selfie', 'verification', 'legal'])) {
    return '/kyc';
  }
  if (_containsAny(id, ['profile', 'security', 'language', 'personal'])) {
    return '/profile';
  }
  if (_containsAny(id, ['notification'])) {
    return '/notifications';
  }
  if (_containsAny(id, ['help', 'support'])) {
    return '/help';
  }
  if (_containsAny(id, ['sign_in', 'create_account', 'welcome', 'email'])) {
    return '/auth';
  }
  return null;
}

bool _containsAny(String id, List<String> needles) {
  for (final needle in needles) {
    if (id.contains(needle)) {
      return true;
    }
  }
  return false;
}
