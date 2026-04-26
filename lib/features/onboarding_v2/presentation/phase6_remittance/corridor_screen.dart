import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/region_picker_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-6.2.1..3** — Corridor picker (Phase 6.2).
///
/// D-024 pre-fill rules:
/// - Diaspora primary regions (CA/GB/US/AE/SA) → "Send to" defaults to
///   secondary regions (typically PK/IN/BD/NP/LK)
/// - South Asian primary regions (PK/IN/BD/NP/LK) → "Receive from"
///   defaults to secondary regions
/// User can override pre-fills.
class CorridorScreen extends ConsumerStatefulWidget {
  const CorridorScreen({super.key});

  @override
  ConsumerState<CorridorScreen> createState() => _CorridorScreenState();
}

class _CorridorScreenState extends ConsumerState<CorridorScreen>
    with OnboardingAnalyticsMixin<CorridorScreen> {
  @override
  int get phase => 6;

  @override
  String get stepId => 'phase6_step2';

  @override
  String get frdId => 'FR-6.2.1';

  static const _diasporaPrimaries = {'CA', 'GB', 'US', 'AE', 'SA'};
  static const _southAsianPrimaries = {'PK', 'IN', 'BD', 'NP', 'LK'};

  Set<String> _sendsTo = {};
  Set<String> _receivesFrom = {};

  @override
  void initState() {
    super.initState();
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    if (stored == null) return;

    // Hydrate from persisted state if present.
    _sendsTo = stored.sendsTo.toSet();
    _receivesFrom = stored.receivesFrom.toSet();

    // D-024 pre-fill: only apply if user hasn't already set values.
    final primary = stored.primaryRegion;
    final secondary = stored.secondaryRegions.toSet();
    if (primary == null) return;

    if (_sendsTo.isEmpty &&
        _diasporaPrimaries.contains(primary) &&
        secondary.isNotEmpty) {
      // Diaspora user → likely sends home to secondary regions.
      _sendsTo = secondary
          .where((iso) => _southAsianPrimaries.contains(iso))
          .toSet();
      // Fallback: if no SA secondary, just pre-fill any secondary.
      if (_sendsTo.isEmpty) _sendsTo = secondary;
    }

    if (_receivesFrom.isEmpty &&
        _southAsianPrimaries.contains(primary) &&
        secondary.isNotEmpty) {
      // South Asian user with diaspora ties → likely receives from there.
      _receivesFrom = secondary
          .where((iso) => _diasporaPrimaries.contains(iso))
          .toSet();
      if (_receivesFrom.isEmpty) _receivesFrom = secondary;
    }
  }

  /// Audit §4 — filter by `country_status` AND pair-level
  /// `country_corridors`. `country_status != 'active'` is dropped
  /// outright; pairs flagged blocked/sanctioned for the user's primary
  /// region are dropped from corridor pickers.
  List<RegionOption> _regionOptions(Map<String, dynamic>? config) {
    final raw = config?['regions'] as List<dynamic>?;
    if (raw == null) return _bundledRegions;
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    final primary = stored?.primaryRegion;
    final corridors = (config?['country_corridors'] as List<dynamic>?) ?? const [];
    final blockedFromPrimary = <String>{
      for (final c in corridors)
        if (primary != null &&
            (c as Map)['from'] == primary &&
            c['status'] != 'allowed')
          c['to'].toString(),
    };
    return raw
        .where((r) {
          final status = (r as Map)['country_status']?.toString() ?? 'active';
          if (status != 'active') return false;
          if (blockedFromPrimary.contains(r['iso2'])) return false;
          return true;
        })
        .map((r) => RegionOption(
              iso2: r['iso2'].toString(),
              name: r['name'].toString(),
              currencyIso: r['currency_iso'].toString(),
              dialCode: r['dial_code'].toString(),
            ))
        .toList();
  }

  static const List<RegionOption> _bundledRegions = [
    RegionOption(iso2: 'PK', name: 'Pakistan', currencyIso: 'PKR', dialCode: '+92'),
    RegionOption(iso2: 'IN', name: 'India', currencyIso: 'INR', dialCode: '+91'),
    RegionOption(iso2: 'BD', name: 'Bangladesh', currencyIso: 'BDT', dialCode: '+880'),
    RegionOption(iso2: 'NP', name: 'Nepal', currencyIso: 'NPR', dialCode: '+977'),
    RegionOption(iso2: 'LK', name: 'Sri Lanka', currencyIso: 'LKR', dialCode: '+94'),
    RegionOption(iso2: 'CA', name: 'Canada', currencyIso: 'CAD', dialCode: '+1'),
    RegionOption(iso2: 'GB', name: 'United Kingdom', currencyIso: 'GBP', dialCode: '+44'),
    RegionOption(iso2: 'US', name: 'United States', currencyIso: 'USD', dialCode: '+1'),
    RegionOption(iso2: 'AE', name: 'UAE', currencyIso: 'AED', dialCode: '+971'),
    RegionOption(iso2: 'SA', name: 'Saudi Arabia', currencyIso: 'SAR', dialCode: '+966'),
  ];

  Future<void> _pickSendsTo(List<RegionOption> regions) async {
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    final primary = stored?.primaryRegion;
    final filtered =
        regions.where((r) => r.iso2 != primary).toList();
    final result = await RegionPickerSheet.show(
      context: context,
      regions: filtered,
      multiSelect: true,
      maxSelections: 3,
      initialSelected: _sendsTo,
      title: 'Send money to',
      subtitle: 'Pick the country (or countries) you send money to.',
    );
    if (result is Set<String>) {
      setState(() => _sendsTo = result);
    }
  }

  Future<void> _pickReceivesFrom(List<RegionOption> regions) async {
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    final primary = stored?.primaryRegion;
    final filtered =
        regions.where((r) => r.iso2 != primary).toList();
    final result = await RegionPickerSheet.show(
      context: context,
      regions: filtered,
      multiSelect: true,
      maxSelections: 3,
      initialSelected: _receivesFrom,
      title: 'Receive money from',
      subtitle: 'Pick the country (or countries) you receive money from.',
    );
    if (result is Set<String>) {
      setState(() => _receivesFrom = result);
    }
  }

  Future<void> _continue() async {
    if (_sendsTo.isEmpty && _receivesFrom.isEmpty) {
      await onValidationError('no_corridor_selected');
      return;
    }
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(
            sendsTo: _sendsTo.toList(),
            receivesFrom: _receivesFrom.toList(),
          ),
        );
    await onContinue({
      'sends_to_count': _sendsTo.length,
      'receives_from_count': _receivesFrom.length,
    });
    if (!mounted) return;
    context.go('/onboarding-v2/personalize');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final regions = _regionOptions(config);
    final canContinue = _sendsTo.isNotEmpty || _receivesFrom.isNotEmpty;

    return OnboardingShell(
      title: 'Where does the money flow?',
      currentStep: 14,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/family-remittance');
      },
      bottomActions: FeloButton(
        label: 'Continue',
        onPressed: canContinue ? _continue : null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          Text(
            'We use this to suggest the right corridor and FX guidance later.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          _CorridorCard(
            icon: Icons.north_east_rounded,
            title: 'Send to',
            subtitle: _sendsTo.isEmpty
                ? 'Tap to add countries'
                : _formatRegions(_sendsTo, regions),
            onTap: () => _pickSendsTo(regions),
          ),
          const SizedBox(height: 12),
          _CorridorCard(
            icon: Icons.south_west_rounded,
            title: 'Receive from',
            subtitle: _receivesFrom.isEmpty
                ? 'Tap to add countries'
                : _formatRegions(_receivesFrom, regions),
            onTap: () => _pickReceivesFrom(regions),
          ),
          const SizedBox(height: 20),
          if (_sendsTo.isEmpty && _receivesFrom.isEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: FeloColors.mintBase.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pick at least one direction to continue.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatRegions(Set<String> isoSet, List<RegionOption> regions) {
    final names = isoSet
        .map((iso) => regions
            .firstWhere(
              (r) => r.iso2 == iso,
              orElse: () => RegionOption(
                iso2: iso,
                name: iso,
                currencyIso: '',
                dialCode: '',
              ),
            )
            .name)
        .toList();
    return names.join(' · ');
  }
}

class _CorridorCard extends StatelessWidget {
  const _CorridorCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: FeloColors.mintBase.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: FeloColors.feloiTeal),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
