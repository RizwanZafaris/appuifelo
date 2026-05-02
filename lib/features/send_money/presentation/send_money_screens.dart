import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/send_money/domain/send_money.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_bottom_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class SendRecipientScreen extends ConsumerWidget {
  const SendRecipientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final recipients = ref.watch(sendRecipientsProvider);
    return FeloScaffold(
      title: l10n.sendTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.sendPickRecipientTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          for (final recipient in recipients) ...[
            FeloCard(
              onTap: () {
                ref.read(sendMoneyFlowProvider.notifier).selectRecipient(
                      recipient,
                    );
                context.push('/send/amount');
              },
              child: _RecipientRow(recipient: recipient),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          FeloButton(
            label: l10n.sendAddRecipient,
            icon: Icons.person_add_alt_1_outlined,
            variant: FeloButtonVariant.secondary,
            onPressed: () async {
              await _showAddRecipientSheet(context, ref);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAddRecipientSheet(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    await showFeloBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.sendAddRecipient,
                style: Theme.of(sheetContext).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 16),
              FeloInput(
                label: l10n.sendRecipientNameLabel,
                controller: nameController,
              ),
              const SizedBox(height: 12),
              FeloInput(
                label: l10n.sendRecipientPhoneLabel,
                controller: phoneController,
              ),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonContinue,
                onPressed: () {
                  final recipient = ref
                      .read(sendMoneyFlowProvider.notifier)
                      .addRecipient(
                        displayName: nameController.text.trim().isEmpty
                            ? l10n.sendRecipientFallback
                            : nameController.text.trim(),
                        phoneMasked: phoneController.text.trim().isEmpty
                            ? l10n.sendRecipientPhoneFallback
                            : phoneController.text.trim(),
                      );
                  ref.read(sendMoneyFlowProvider.notifier).selectRecipient(
                        recipient,
                      );
                  Navigator.of(sheetContext).pop();
                  context.push('/send/amount');
                },
              ),
            ],
          ),
        );
      },
    );

    nameController.dispose();
    phoneController.dispose();
  }
}

class SendAmountScreen extends ConsumerStatefulWidget {
  const SendAmountScreen({super.key});

  @override
  ConsumerState<SendAmountScreen> createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends ConsumerState<SendAmountScreen> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _amountController.addListener(_syncAmount);
  }

  @override
  void dispose() {
    _amountController
      ..removeListener(_syncAmount)
      ..dispose();
    super.dispose();
  }

  void _syncAmount() {
    final parsedAmount = double.tryParse(
      _amountController.text.replaceAll(RegExp('[^0-9.]'), ''),
    );
    final amountMinor = parsedAmount == null ? 0 : (parsedAmount * 100).round();
    ref.read(sendMoneyFlowProvider.notifier).setAmountMinor(amountMinor);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = ref.watch(sendMoneyFlowProvider);
    final quote = draft.quote;
    return FeloScaffold(
      title: l10n.sendAmountTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (draft.recipient == null)
            FeloEmptyState(
              title: l10n.sendNoRecipientTitle,
              body: l10n.sendNoRecipientBody,
              actionLabel: l10n.sendPickRecipientTitle,
              onAction: () => context.go('/send'),
            )
          else ...[
            FeloCard(child: _RecipientRow(recipient: draft.recipient!)),
            const SizedBox(height: 16),
            FeloInput(
              label: l10n.sendAmountLabel,
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            FeloCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote == null || quote.sourceAmountMinor == 0
                        ? l10n.sendFxPreviewEmpty
                        : l10n.sendFxPreview(
                            formatMinorMoney(
                              minor: quote.targetAmountMinor,
                              currency: quote.targetCurrency,
                            ),
                          ),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  if (quote != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.sendFxRate(
                        quote.rate.toStringAsFixed(2),
                        quote.sourceCurrency,
                        quote.targetCurrency,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            FeloButton(
              label: l10n.commonContinue,
              onPressed: quote == null || quote.sourceAmountMinor == 0
                  ? null
                  : () => context.push('/send/review'),
            ),
          ],
        ],
      ),
    );
  }
}

class SendReviewScreen extends ConsumerWidget {
  const SendReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(sendMoneyFlowProvider);
    final quote = draft.quote;
    final recipient = draft.recipient;
    return FeloScaffold(
      title: l10n.sendReviewTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (recipient == null || quote == null)
            FeloEmptyState(
              title: l10n.sendReviewMissingTitle,
              body: l10n.sendReviewMissingBody,
              actionLabel: l10n.sendPickRecipientTitle,
              onAction: () => context.go('/send'),
            )
          else ...[
            FeloCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ReviewRow(
                    label: l10n.sendRecipientLabel,
                    value: recipient.displayName,
                  ),
                  _ReviewRow(
                    label: l10n.sendAmountLabel,
                    value: formatMinorMoney(
                      minor: quote.sourceAmountMinor,
                      currency: quote.sourceCurrency,
                    ),
                  ),
                  _ReviewRow(
                    label: l10n.sendRecipientGetsLabel,
                    value: formatMinorMoney(
                      minor: quote.targetAmountMinor,
                      currency: quote.targetCurrency,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FeloCard(
              child: Text(
                l10n.sendPreviewDisclaimer,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            FeloButton(
              label: l10n.sendConfirmPreview,
              onPressed: () {
                ref.read(sendMoneyFlowProvider.notifier).completePreview();
                context.push('/send/success');
              },
            ),
          ],
        ],
      ),
    );
  }
}

class SendSuccessScreen extends ConsumerWidget {
  const SendSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final draft = ref.watch(sendMoneyFlowProvider);
    return FeloScaffold(
      title: l10n.sendSuccessTitle,
      selectedTab: FeloRootTab.home,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FeloCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 56,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.sendSuccessTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.sendSuccessBody(draft.referenceId ?? ''),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonContinue,
                onPressed: () {
                  ref.read(sendMoneyFlowProvider.notifier).reset();
                  context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipientRow extends StatelessWidget {
  const _RecipientRow({required this.recipient});

  final SendRecipient recipient;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person_outline_rounded),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipient.displayName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(recipient.phoneMasked),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
