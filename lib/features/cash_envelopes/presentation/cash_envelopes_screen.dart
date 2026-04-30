import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/core/widgets/felo_card.dart';
import 'package:felo/core/widgets/felo_scaffold.dart';
import 'package:felo/core/widgets/felo_empty_state.dart';
import 'package:felo/features/cash_envelopes/application/cash_envelopes_providers.dart';
import 'package:felo/features/cash_envelopes/domain/cash_envelope.dart';

class CashEnvelopesScreen extends ConsumerWidget {
  const CashEnvelopesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envelopesAsync = ref.watch(cashEnvelopesProvider);

    return FeloScaffold(
      appBar: AppBar(
        title: const Text('Cash Envelopes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEnvelopeSheet(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Envelope'),
      ),
      body: envelopesAsync.when(
        data: (envelopes) => envelopes.isEmpty
            ? FeloEmptyState(
                icon: Icons.account_balance_wallet_outlined,
                title: 'No Cash Envelopes',
                subtitle: 'Create envelopes to track your cash spending by category.',
                actionLabel: 'Create First Envelope',
                onAction: () => _showAddEnvelopeSheet(context, ref),
              )
            : _EnvelopesList(envelopes: envelopes),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => FeloEmptyState(
          icon: Icons.error_outline,
          title: 'Error',
          subtitle: e.toString(),
          actionLabel: 'Retry',
          onAction: () => ref.invalidate(cashEnvelopesProvider),
        ),
      ),
    );
  }

  void _showAddEnvelopeSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const _AddEnvelopeSheet(),
    );
  }
}

class _EnvelopesList extends StatelessWidget {
  final List<CashEnvelope> envelopes;
  const _EnvelopesList({required this.envelopes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: envelopes.length,
      itemBuilder: (context, index) => _EnvelopeCard(envelope: envelopes[index]),
    );
  }
}

class _EnvelopeCard extends StatelessWidget {
  final CashEnvelope envelope;
  const _EnvelopeCard({required this.envelope});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final progress = envelope.budgetMinor > 0
        ? (envelope.spentMinor / envelope.budgetMinor).clamp(0.0, 1.0)
        : 0.0;
    final remaining = envelope.budgetMinor - envelope.spentMinor;
    final isOverBudget = remaining < 0;

    return FeloCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(envelope.name, style: theme.textTheme.titleMedium),
                    Text(
                      envelope.category,
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text(envelope.period),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spent: ${formatter.format(envelope.spentMinor / 100)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                isOverBudget
                    ? 'Over: ${formatter.format(-remaining / 100)}'
                    : 'Left: ${formatter.format(remaining / 100)}',
                style: TextStyle(
                  color: isOverBudget ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(
              isOverBudget ? Colors.red : progress > 0.8 ? Colors.orange : Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => _showSpendSheet(context, envelope),
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                label: const Text('Spend'),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSpendSheet(BuildContext context, CashEnvelope envelope) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _SpendSheet(envelope: envelope),
    );
  }
}

class _AddEnvelopeSheet extends ConsumerStatefulWidget {
  const _AddEnvelopeSheet();

  @override
  ConsumerState<_AddEnvelopeSheet> createState() => _AddEnvelopeSheetState();
}

class _AddEnvelopeSheetState extends ConsumerState<_AddEnvelopeSheet> {
  final _nameController = TextEditingController();
  final _budgetController = TextEditingController();
  String _category = 'Food';
  String _period = 'monthly';

  final _categories = ['Food', 'Transport', 'Shopping', 'Entertainment', 'Bills', 'Family', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('New Cash Envelope', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Envelope Name',
              hintText: 'e.g., Weekly Groceries',
              prefixIcon: Icon(Icons.label_outline),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _category,
            decoration: const InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(Icons.category),
            ),
            items: _categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _category = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Budget Amount',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'weekly', label: Text('Weekly')),
              ButtonSegment(value: 'monthly', label: Text('Monthly')),
            ],
            selected: {_period},
            onSelectionChanged: (s) => setState(() => _period = s.first),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              final budget = int.tryParse(_budgetController.text) ?? 0;
              if (_nameController.text.isNotEmpty && budget > 0) {
                ref.read(cashEnvelopesRepositoryProvider).create(
                  name: _nameController.text,
                  category: _category,
                  budgetMinor: budget * 100,
                  period: _period,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Create Envelope'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SpendSheet extends ConsumerStatefulWidget {
  final CashEnvelope envelope;
  const _SpendSheet({required this.envelope});

  @override
  ConsumerState<_SpendSheet> createState() => _SpendSheetState();
}

class _SpendSheetState extends ConsumerState<_SpendSheet> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Spend from ${widget.envelope.name}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Available: \$${((widget.envelope.budgetMinor - widget.envelope.spentMinor) / 100).toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              final amount = int.tryParse(_amountController.text) ?? 0;
              if (amount > 0) {
                ref.read(cashEnvelopesRepositoryProvider).spend(
                  widget.envelope.id,
                  amount * 100,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Record Spend'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
