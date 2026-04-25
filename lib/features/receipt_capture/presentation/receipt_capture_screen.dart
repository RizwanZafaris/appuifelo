import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/receipt_capture/domain/receipt_capture.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_bottom_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class ReceiptCaptureScreen extends ConsumerWidget {
  const ReceiptCaptureScreen({required this.transactionId, super.key});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final transaction = ref
        .watch(transactionsProvider)
        .firstWhere((item) => item.id == transactionId);
    final state = ref.watch(receiptCaptureSessionProvider(transactionId));
    final session = ref.read(
      receiptCaptureSessionProvider(transactionId).notifier,
    );

    return FeloScaffold(
      title: l10n.receiptCaptureTitle,
      selectedTab: FeloRootTab.activity,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Row(
              children: [
                const Icon(Icons.receipt_long_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.merchant,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatMinorMoney(
                          minor: transaction.amountMinor,
                          currency: transaction.currency,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (transaction.receiptId != null)
                  Chip(label: Text(l10n.receiptAttached)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          switch (state) {
            ReceiptCaptureIdle() => _CaptureEntryPoints(
              onCamera: () => session.pick(ReceiptCaptureSource.camera),
              onGallery: () => session.pick(ReceiptCaptureSource.gallery),
            ),
            ReceiptCaptureProcessing() => _ProcessingCard(
              label: l10n.receiptProcessing,
            ),
            ReceiptCaptureReady(:final result) => _OcrResultCard(
              result: result,
              onConfirm: session.confirm,
              onEdit: () async {
                await _showEditSheet(context, ref, transactionId, result);
              },
              onDiscard: session.discard,
            ),
            ReceiptCaptureConfirmed(:final result) => _ConfirmedCard(
              result: result,
            ),
          },
        ],
      ),
    );
  }

  Future<void> _showEditSheet(
    BuildContext context,
    WidgetRef ref,
    String transactionId,
    ReceiptOcrResult result,
  ) async {
    final l10n = context.l10n;
    final merchantController = TextEditingController(text: result.merchant);
    final totalController = TextEditingController(
      text: (result.totalMinor / 100).toStringAsFixed(2),
    );

    ref.read(receiptCaptureSessionProvider(transactionId).notifier).edit();

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
                l10n.receiptEditTitle,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              FeloInput(
                label: l10n.receiptMerchantLabel,
                controller: merchantController,
              ),
              const SizedBox(height: 12),
              FeloInput(
                label: l10n.receiptTotalLabel,
                controller: totalController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonSave,
                onPressed: () {
                  final parsedTotal = double.tryParse(
                    totalController.text.replaceAll(RegExp('[^0-9.]'), ''),
                  );
                  final totalMinor = parsedTotal == null
                      ? result.totalMinor
                      : (parsedTotal * 100).round();
                  ref
                      .read(
                        receiptCaptureSessionProvider(transactionId).notifier,
                      )
                      .applyEdit(
                        merchant: merchantController.text.trim().isEmpty
                            ? result.merchant
                            : merchantController.text.trim(),
                        totalMinor: totalMinor,
                      );
                  Navigator.of(sheetContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    merchantController.dispose();
    totalController.dispose();
  }
}

class _CaptureEntryPoints extends StatelessWidget {
  const _CaptureEntryPoints({required this.onCamera, required this.onGallery});

  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.receiptCaptureBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          FeloButton(
            label: l10n.receiptUseCamera,
            icon: Icons.photo_camera_outlined,
            onPressed: onCamera,
          ),
          const SizedBox(height: 10),
          FeloButton(
            label: l10n.receiptUseGallery,
            icon: Icons.photo_library_outlined,
            variant: FeloButtonVariant.secondary,
            onPressed: onGallery,
          ),
        ],
      ),
    );
  }
}

class _ProcessingCard extends StatelessWidget {
  const _ProcessingCard({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FeloProgressRing(progress: 0.64, label: label),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OcrResultCard extends StatelessWidget {
  const _OcrResultCard({
    required this.result,
    required this.onConfirm,
    required this.onEdit,
    required this.onDiscard,
  });

  final ReceiptOcrResult result;
  final VoidCallback onConfirm;
  final VoidCallback onEdit;
  final VoidCallback onDiscard;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final materialLocalizations = MaterialLocalizations.of(context);
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.receiptOcrResultTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          _ReceiptRow(label: l10n.receiptMerchantLabel, value: result.merchant),
          _ReceiptRow(
            label: l10n.receiptDateLabel,
            value: materialLocalizations.formatShortDate(result.purchasedAt),
          ),
          _ReceiptRow(
            label: l10n.receiptTotalLabel,
            value: formatMinorMoney(
              minor: result.totalMinor,
              currency: result.currency,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.receiptLineItemsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          for (final item in result.lineItems)
            _ReceiptRow(
              label: item.name,
              value: formatMinorMoney(
                minor: item.amountMinor,
                currency: result.currency,
              ),
            ),
          const SizedBox(height: 18),
          FeloButton(
            label: l10n.receiptConfirm,
            icon: Icons.check_rounded,
            onPressed: onConfirm,
          ),
          const SizedBox(height: 10),
          FeloButton(
            label: l10n.commonEdit,
            variant: FeloButtonVariant.secondary,
            icon: Icons.edit_outlined,
            onPressed: onEdit,
          ),
          const SizedBox(height: 10),
          FeloButton(
            label: l10n.receiptDiscard,
            variant: FeloButtonVariant.ghost,
            icon: Icons.delete_outline_rounded,
            onPressed: onDiscard,
          ),
        ],
      ),
    );
  }
}

class _ConfirmedCard extends StatelessWidget {
  const _ConfirmedCard({required this.result});

  final ReceiptOcrResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        children: [
          Icon(
            Icons.verified_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.receiptConfirmedTitle,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.receiptConfirmedBody(result.id),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
