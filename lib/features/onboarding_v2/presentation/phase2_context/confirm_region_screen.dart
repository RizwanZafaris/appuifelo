import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_config_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/region_picker_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-2.1.1** — Confirm region screen.
///
/// On mount: POST /v1/onboarding/region/resolve. If country detected,
/// pre-fills the big confirmation card. User taps "Yes that's me" or
/// "Pick a different country" or "+ Add another region".
class ConfirmRegionScreen extends ConsumerStatefulWidget {
  const ConfirmRegionScreen({super.key});

  @override
  ConsumerState<ConfirmRegionScreen> createState() =>
      _ConfirmRegionScreenState();
}

class _ConfirmRegionScreenState extends ConsumerState<ConfirmRegionScreen>
    with OnboardingAnalyticsMixin<ConfirmRegionScreen> {
  @override
  int get phase => 2;

  @override
  String get stepId => 'phase2_step1';

  @override
  String get frdId => 'FR-2.1.1';

  String? _detectedCountry;
  bool _resolving = true;
  String? _confirmedRegion;
  Set<String> _secondaryRegions = {};

  @override
  void initState() {
    super.initState();
    _resolveIp();
    // Hydrate from persisted state (resume flow)
    final stored = ref.read(onboardingStateControllerProvider).valueOrNull;
    if (stored != null) {
      _confirmedRegion = stored.primaryRegion;
      _secondaryRegions = stored.secondaryRegions.toSet();
    }
  }

  Future<void> _resolveIp() async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post<Map<String, dynamic>>(
        '/onboarding/region/resolve',
      );
      final country = response.data?['country']?.toString();
      setState(() {
        _detectedCountry = country;
        _confirmedRegion ??= country;
        _resolving = false;
      });
    } on DioException {
      setState(() => _resolving = false);
    }
  }

  /// Audit §4 — only `country_status = 'active'` regions appear in the
  /// primary picker. Sanctioned / not_supported / coming_soon are
  /// filtered out so the user can never select them.
  List<RegionOption> _regionOptions(Map<String, dynamic>? config) {
    final raw = config?['regions'] as List<dynamic>?;
    if (raw == null) return _bundledRegions;
    return raw
        .where((r) {
          final status = (r as Map)['country_status']?.toString() ?? 'active';
          return status == 'active';
        })
        .map((r) => RegionOption(
              iso2: r['iso2'].toString(),
              name: r['name'].toString(),
              currencyIso: r['currency_iso'].toString(),
              dialCode: r['dial_code'].toString(),
            ))
        .toList();
  }

  // Bundled fallback if journey-config hasn't loaded yet.
  static const List<RegionOption> _bundledRegions = [
    RegionOption(iso2: 'PK', name: 'Pakistan', currencyIso: 'PKR', dialCode: '+92'),
    RegionOption(iso2: 'IN', name: 'India', currencyIso: 'INR', dialCode: '+91'),
    RegionOption(iso2: 'BD', name: 'Bangladesh', currencyIso: 'BDT', dialCode: '+880'),
    RegionOption(iso2: 'CA', name: 'Canada', currencyIso: 'CAD', dialCode: '+1'),
    RegionOption(iso2: 'GB', name: 'United Kingdom', currencyIso: 'GBP', dialCode: '+44'),
    RegionOption(iso2: 'US', name: 'United States', currencyIso: 'USD', dialCode: '+1'),
    RegionOption(iso2: 'AE', name: 'UAE', currencyIso: 'AED', dialCode: '+971'),
    RegionOption(iso2: 'SA', name: 'Saudi Arabia', currencyIso: 'SAR', dialCode: '+966'),
  ];

  RegionOption? _regionByIso(List<RegionOption> regions, String? iso2) {
    if (iso2 == null) return null;
    for (final r in regions) {
      if (r.iso2 == iso2) return r;
    }
    return null;
  }

  Future<void> _pickPrimary(List<RegionOption> regions) async {
    final result = await RegionPickerSheet.show(
      context: context,
      regions: regions,
      title: 'Pick your country',
    );
    if (result is String) {
      setState(() => _confirmedRegion = result);
    }
  }

  Future<void> _addSecondary(List<RegionOption> regions) async {
    final filtered = regions
        .where((r) => r.iso2 != _confirmedRegion)
        .toList();
    final result = await RegionPickerSheet.show(
      context: context,
      regions: filtered,
      multiSelect: true,
      maxSelections: 3,
      initialSelected: _secondaryRegions,
      title: 'Add another region',
      subtitle:
          'Pick countries you have ties to (e.g., where family lives or money flows).',
    );
    if (result is Set<String>) {
      setState(() => _secondaryRegions = result);
    }
  }

  Future<void> _continue() async {
    if (_confirmedRegion == null) {
      await onValidationError('no_primary_region');
      return;
    }
    await ref.read(onboardingStateControllerProvider.notifier).patch(
          (s) => s.copyWith(
            primaryRegion: _confirmedRegion,
            secondaryRegions: _secondaryRegions.toList(),
            ipCountry: _detectedCountry,
          ),
        );
    await onContinue({
      'primary_region': _confirmedRegion,
      'secondary_count': _secondaryRegions.length,
      'prefilled': _confirmedRegion == _detectedCountry,
    });
    if (!mounted) return;
    context.go('/onboarding-v2/name');
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(onboardingConfigProvider).valueOrNull;
    final regions = _regionOptions(config);
    final detected = _regionByIso(regions, _detectedCountry);
    final confirmed = _regionByIso(regions, _confirmedRegion);

    return OnboardingShell(
      title: 'Where are you?',
      currentStep: 4,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/signup-method');
      },
      bottomActions: FeloButton(
        label: 'Continue',
        onPressed: _confirmedRegion == null ? null : _continue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          if (_resolving)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            _RegionConfirmCard(
              region: confirmed ?? detected,
              autoDetected: _detectedCountry != null &&
                  _confirmedRegion == _detectedCountry,
              onChange: () => _pickPrimary(regions),
            ),
            const SizedBox(height: 16),
            if (_secondaryRegions.isNotEmpty) ...[
              Text(
                'Other regions you have ties to',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _secondaryRegions
                    .map((iso) => _regionByIso(regions, iso))
                    .where((r) => r != null)
                    .cast<RegionOption>()
                    .map((r) => Chip(
                          label: Text('${r.iso2} · ${r.currencyIso}'),
                          onDeleted: () {
                            setState(() => _secondaryRegions.remove(r.iso2));
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
            ],
            OutlinedButton.icon(
              icon: const Icon(Icons.add_rounded),
              label: Text(
                _secondaryRegions.isEmpty
                    ? '+ Add another region'
                    : '+ Add another (${_secondaryRegions.length}/3)',
              ),
              onPressed: _secondaryRegions.length >= 3
                  ? null
                  : () => _addSecondary(regions),
            ),
          ],
        ],
      ),
    );
  }
}

class _RegionConfirmCard extends StatelessWidget {
  const _RegionConfirmCard({
    required this.region,
    required this.autoDetected,
    required this.onChange,
  });

  final RegionOption? region;
  final bool autoDetected;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    if (region == null) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Icon(Icons.public_rounded, size: 40),
            const SizedBox(height: 12),
            Text(
              "We couldn't detect your country automatically — please pick from the list below.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: onChange,
              child: const Text('Pick country'),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FeloColors.mintBase.withValues(alpha: 0.5),
            FeloColors.mintBase.withValues(alpha: 0.25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: FeloColors.feloiTeal.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.location_on_rounded,
            size: 48,
            color: FeloColors.feloiTeal,
          ),
          const SizedBox(height: 14),
          Text(
            autoDetected ? "You're in ${region!.name}?" : region!.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            '${region!.dialCode} · ${region!.currencyIso}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: onChange,
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('Pick a different country'),
          ),
        ],
      ),
    );
  }
}
