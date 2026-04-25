import 'package:flutter/material.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';

class RemittanceStubScreen extends StatelessWidget {
  const RemittanceStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloFeaturePlaceholder(
      title: l10n.remittanceTitle,
      body: l10n.remittanceBody,
      icon: Icons.public_rounded,
      children: [
        FeloButton(label: l10n.remittanceCta, onPressed: () {}),
      ],
    );
  }
}
