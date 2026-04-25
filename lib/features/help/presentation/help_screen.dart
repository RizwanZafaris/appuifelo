import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class HelpScreen extends ConsumerStatefulWidget {
  const HelpScreen({super.key});

  @override
  ConsumerState<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends ConsumerState<HelpScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleQueryChange);
  }

  void _handleQueryChange() {
    setState(() => _query = _searchController.text.trim());
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleQueryChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final faqs = _buildFaqs(l10n);
    final filtered = _query.isEmpty
        ? faqs
        : faqs
            .where(
              (f) =>
                  f.question.toLowerCase().contains(_query.toLowerCase()) ||
                  f.answer.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList();

    return FeloScaffold(
      title: l10n.helpTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloInput(
            label: l10n.helpSearchLabel,
            hint: l10n.helpSearchHint,
            controller: _searchController,
          ),
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            FeloCard(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(l10n.helpNoResults),
              ),
            )
          else
            ...filtered.map(
              (faq) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FeloCard(
                  padding: EdgeInsets.zero,
                  child: ExpansionTile(
                    title: Text(
                      faq.question,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(faq.answer),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.mail_outline_rounded,
            label: l10n.helpContactSupport,
            value: 'support@felo.app',
          ),
          const SizedBox(height: 8),
          _ContactRow(
            icon: Icons.bug_report_outlined,
            label: l10n.helpReportBug,
            value: 'bugs@felo.app',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _LegalLink(label: l10n.helpTerms)),
              const SizedBox(width: 8),
              Expanded(child: _LegalLink(label: l10n.helpPrivacy)),
              const SizedBox(width: 8),
              Expanded(child: _LegalLink(label: l10n.helpLicenses)),
            ],
          ),
        ],
      ),
    );
  }

  List<_Faq> _buildFaqs(AppLocalizations l10n) {
    return [
      _Faq(question: l10n.helpFaq1Q, answer: l10n.helpFaq1A),
      _Faq(question: l10n.helpFaq2Q, answer: l10n.helpFaq2A),
      _Faq(question: l10n.helpFaq3Q, answer: l10n.helpFaq3A),
      _Faq(question: l10n.helpFaq4Q, answer: l10n.helpFaq4A),
      _Faq(question: l10n.helpFaq5Q, answer: l10n.helpFaq5A),
    ];
  }
}

class _Faq {
  const _Faq({required this.question, required this.answer});
  final String question;
  final String answer;
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label: $value')),
          );
        }
      },
      semanticLabel: '$label $value',
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.copy_rounded, size: 18),
        ],
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(label)),
        );
      },
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
