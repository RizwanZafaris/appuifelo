import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/bills/domain/bill.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_bottom_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final bills = ref.watch(billsProvider);
    final sortedBills = [...bills]
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return FeloScaffold(
      title: l10n.billsTitle,
      selectedTab: FeloRootTab.home,
      actions: [
        IconButton(
          tooltip: l10n.billsAddBill,
          onPressed: () async {
            await _showAddBillSheet(context, ref);
          },
          icon: const Icon(Icons.add_rounded),
        ),
      ],
      child: bills.isEmpty
          ? FeloEmptyState(
              title: l10n.billsEmptyTitle,
              body: l10n.billsEmptyBody,
              actionLabel: l10n.billsAddBill,
              onAction: () async {
                await _showAddBillSheet(context, ref);
              },
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _CalendarStrip(bills: sortedBills),
                const SizedBox(height: 16),
                for (final bill in sortedBills) ...[
                  _BillCard(bill: bill),
                  const SizedBox(height: 12),
                ],
              ],
            ),
    );
  }

  Future<void> _showAddBillSheet(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final dueDayController = TextEditingController();

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
                l10n.billsAddBill,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              FeloInput(label: l10n.billsNameLabel, controller: nameController),
              const SizedBox(height: 12),
              FeloInput(
                label: l10n.billsAmountLabel,
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              FeloInput(
                label: l10n.billsDueDayLabel,
                controller: dueDayController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonSave,
                onPressed: () {
                  final parsedAmount = double.tryParse(
                    amountController.text.replaceAll(RegExp('[^0-9.]'), ''),
                  );
                  final parsedDay = int.tryParse(
                    dueDayController.text.replaceAll(RegExp('[^0-9]'), ''),
                  );
                  final amountMinor = parsedAmount == null
                      ? 0
                      : (parsedAmount * 100).round();
                  final dueDay = (parsedDay ?? DateTime.now().day).clamp(1, 28);
                  final today = DateTime.now();
                  ref
                      .read(billsProvider.notifier)
                      .addManualBill(
                        name: nameController.text.trim().isEmpty
                            ? l10n.billsManualNameFallback
                            : nameController.text.trim(),
                        amountMinor: amountMinor,
                        dueDate: DateTime(today.year, today.month + 1, dueDay),
                      );
                  Navigator.of(sheetContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    nameController.dispose();
    amountController.dispose();
    dueDayController.dispose();
  }
}

class _CalendarStrip extends StatelessWidget {
  const _CalendarStrip({required this.bills});

  final List<Bill> bills;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final materialLocalizations = MaterialLocalizations.of(context);
    final upcomingBills = bills.where(
      (bill) => bill.status == BillStatus.upcoming,
    );
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.billsCalendarTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final bill in upcomingBills) ...[
                  FeloChip(
                    label: materialLocalizations.formatShortDate(bill.dueDate),
                    icon: _categoryIcon(bill.category),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BillCard extends ConsumerWidget {
  const _BillCard({required this.bill});

  final Bill bill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final materialLocalizations = MaterialLocalizations.of(context);
    final isPaid = bill.status == BillStatus.paid;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_categoryIcon(bill.category)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.billsDueDate(
                        materialLocalizations.formatShortDate(bill.dueDate),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatMinorMoney(
                  minor: bill.amountMinor,
                  currency: bill.currency,
                ),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FeloChip(label: _categoryLabel(context, bill.category)),
              FeloChip(
                label: bill.autoPayEnabled
                    ? l10n.billsAutoPayOn
                    : l10n.billsAutoPayOff,
              ),
              FeloChip(label: _sourceLabel(context, bill.source)),
              FeloChip(
                label: isPaid ? l10n.billsStatusPaid : l10n.billsStatusUpcoming,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FeloButton(
                  label: l10n.billsPayPreview,
                  variant: FeloButtonVariant.secondary,
                  onPressed: () async {
                    await _showPayPreviewSheet(context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FeloButton(
                  label: l10n.billsMarkPaid,
                  onPressed: isPaid
                      ? null
                      : () =>
                            ref.read(billsProvider.notifier).markPaid(bill.id),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showPayPreviewSheet(BuildContext context) {
    final l10n = context.l10n;
    return showFeloBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.billsPayPreview,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(l10n.billsPayPreviewBody),
              const SizedBox(height: 20),
              FeloButton(
                label: l10n.commonContinue,
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

IconData _categoryIcon(BillCategory category) {
  return switch (category) {
    BillCategory.utility => Icons.bolt_outlined,
    BillCategory.telecom => Icons.phone_android_outlined,
    BillCategory.rent => Icons.home_outlined,
    BillCategory.subscription => Icons.subscriptions_outlined,
  };
}

String _categoryLabel(BuildContext context, BillCategory category) {
  final l10n = context.l10n;
  return switch (category) {
    BillCategory.utility => l10n.billsCategoryUtility,
    BillCategory.telecom => l10n.billsCategoryTelecom,
    BillCategory.rent => l10n.billsCategoryRent,
    BillCategory.subscription => l10n.billsCategorySubscription,
  };
}

String _sourceLabel(BuildContext context, BillSource source) {
  final l10n = context.l10n;
  return switch (source) {
    BillSource.manual => l10n.billsSourceManual,
    BillSource.sms => l10n.billsSourceSms,
  };
}
