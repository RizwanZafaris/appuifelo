import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('Felo shared component suite', (tester) async {
    final builder =
        GoldenBuilder.column(wrap: (child) => _GoldenHost(child: child))
          ..addScenario(
            'Cards, chips, buttons, inputs',
            const _ComponentGallery(),
          )
          ..addScenario('Empty state and progress ring', const _StateGallery());

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(430, 1300),
    );
    await screenMatchesGolden(tester, 'felo_shared_components');
  });
}

class _GoldenHost extends StatelessWidget {
  const _GoldenHost({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = FeloTheme.dark();
    return Localizations(
      locale: const Locale('en'),
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: MediaQuery(
        data: const MediaQueryData(size: Size(390, 844)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Theme(
            data: theme,
            child: Material(
              color: theme.scaffoldBackgroundColor,
              child: SizedBox(
                width: 390,
                child: Padding(padding: const EdgeInsets.all(20), child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComponentGallery extends StatelessWidget {
  const _ComponentGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FeloCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Across connected accounts',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'CAD 4,280',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FeloChip(
              label: 'Groceries',
              icon: Icons.shopping_basket_outlined,
              selected: true,
            ),
            FeloChip(label: 'Family', icon: Icons.groups_2_outlined),
            FeloChip(label: 'SMS', icon: Icons.sms_outlined),
          ],
        ),
        const SizedBox(height: 12),
        FeloButton(
          label: 'Create budget',
          icon: Icons.add_rounded,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        FeloButton(
          label: 'View details',
          variant: FeloButtonVariant.secondary,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        FeloButton(
          label: 'Skip for now',
          variant: FeloButtonVariant.ghost,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        const FeloInput(label: 'Budget name', hint: 'Groceries'),
      ],
    );
  }
}

class _StateGallery extends StatelessWidget {
  const _StateGallery();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FeloProgressRing(progress: 0.68, label: 'Budget used'),
        SizedBox(height: 16),
        FeloEmptyState(
          title: 'Nothing here yet',
          body: 'Seeded mock data will appear as each feature becomes active.',
        ),
      ],
    );
  }
}
