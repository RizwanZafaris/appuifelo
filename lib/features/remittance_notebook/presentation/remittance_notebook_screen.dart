import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/core/widgets/felo_card.dart';
import 'package:felo/core/widgets/felo_scaffold.dart';
import 'package:felo/core/widgets/felo_empty_state.dart';
import 'package:felo/features/remittance_notebook/application/remittance_providers.dart';
import 'package:felo/features/remittance_notebook/domain/remittance_entry.dart';

class RemittanceNotebookScreen extends ConsumerWidget {
  const RemittanceNotebookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(remittanceEntriesProvider());
    final summaryAsync = ref.watch(remittanceSummaryProvider);

    return FeloScaffold(
      appBar: AppBar(
        title: const Text('Remittance Notebook'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEntrySheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary card
          summaryAsync.when(
            data: (summary) => _SummaryCard(summary: summary),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Entries list
          Expanded(
            child: entriesAsync.when(
              data: (entries) => entries.isEmpty
                  ? FeloEmptyState(
                      icon: Icons.send_outlined,
                      title: 'No Transfers Logged',
                      subtitle: 'Track your family support and remittances here.',
                      actionLabel: 'Log First Transfer',
                      onAction: () => _showAddEntrySheet(context, ref),
                    )
                  : _EntriesList(entries: entries),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => FeloEmptyState(
                icon: Icons.error_outline,
                title: 'Error',
                subtitle: e.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEntrySheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const _AddEntrySheet(),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final RemittanceSummary summary;
  const _SummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(symbol: 'CAD ', decimalDigits: 0);

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('This Year', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Sent',
                  value: formatter.format(summary.totalSentThisYear / 100),
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'Planned',
                  value: formatter.format(summary.totalPlanned / 100),
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'Avg Rate',
                  value: summary.averageFxRate > 0
                      ? summary.averageFxRate.toStringAsFixed(2)
                      : '-',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _Metric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _EntriesList extends StatelessWidget {
  final List<RemittanceEntry> entries;
  const _EntriesList({required this.entries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) => _EntryCard(entry: entries[index]),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final RemittanceEntry entry;
  const _EntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(symbol: '', decimalDigits: 2);
    final statusColor = _statusColor(entry.status);

    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.recipientName, style: theme.textTheme.titleMedium),
                    if (entry.relationship != null)
                      Text(entry.relationship!, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Chip(
                label: Text(
                  entry.status.toUpperCase(),
                  style: TextStyle(fontSize: 10, color: statusColor),
                ),
                backgroundColor: statusColor.withOpacity(0.1),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${entry.sourceCurrency} ${formatter.format(entry.sourceAmountMinor / 100)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (entry.fxRate != null)
                Text(
                  'Rate: ${entry.fxRate}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
            ],
          ),
          if (entry.provider.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Via ${entry.provider}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
          if (entry.plannedDate != null) ...[
            const SizedBox(height: 4),
            Text(
              'Planned: ${entry.plannedDate}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
          if (entry.notes != null && entry.notes!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(entry.notes!, style: const TextStyle(fontSize: 12)),
          ],
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'sent':
        return Colors.green;
      case 'received':
        return Colors.blue;
      case 'planned':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _AddEntrySheet extends ConsumerStatefulWidget {
  const _AddEntrySheet();

  @override
  ConsumerState<_AddEntrySheet> createState() => _AddEntrySheetState();
}

class _AddEntrySheetState extends ConsumerState<_AddEntrySheet> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  String _provider = 'Wise';
  String _relationship = 'Family';
  String _status = 'planned';

  final _providers = ['Wise', 'Remitly', 'Western Union', 'Xoom', 'Other'];
  final _relationships = ['Family', 'Friend', 'Business', 'Other'];

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
          Text('Log Transfer', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _recipientController,
            decoration: const InputDecoration(
              labelText: 'Recipient Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _relationship,
            decoration: const InputDecoration(
              labelText: 'Relationship',
              prefixIcon: Icon(Icons.people_outline),
            ),
            items: _relationships.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
            onChanged: (v) => setState(() => _relationship = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount (CAD)',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _provider,
            decoration: const InputDecoration(
              labelText: 'Provider',
              prefixIcon: Icon(Icons.business),
            ),
            items: _providers.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
            onChanged: (v) => setState(() => _provider = v!),
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'planned', label: Text('Planned')),
              ButtonSegment(value: 'sent', label: Text('Sent')),
            ],
            selected: {_status},
            onSelectionChanged: (s) => setState(() => _status = s.first),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              prefixIcon: Icon(Icons.notes),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              final amount = int.tryParse(_amountController.text) ?? 0;
              if (_recipientController.text.isNotEmpty && amount > 0) {
                ref.read(remittanceNotebookRepositoryProvider).create({
                  'recipientName': _recipientController.text,
                  'relationship': _relationship,
                  'sourceCurrency': 'CAD',
                  'sourceAmountMinor': amount * 100,
                  'provider': _provider,
                  'status': _status,
                  'notes': _notesController.text.isEmpty ? null : _notesController.text,
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save Entry'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
