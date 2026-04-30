import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:felo/core/widgets/felo_card.dart';
import 'package:felo/core/widgets/felo_scaffold.dart';
import 'package:felo/core/widgets/felo_empty_state.dart';
import 'package:felo/features/monthly_close/application/monthly_close_providers.dart';

class MonthlyCloseScreen extends ConsumerStatefulWidget {
  const MonthlyCloseScreen({super.key});

  @override
  ConsumerState<MonthlyCloseScreen> createState() => _MonthlyCloseScreenState();
}

class _MonthlyCloseScreenState extends ConsumerState<MonthlyCloseScreen> {
  late int _year;
  late int _month;
  Map<String, bool> _checklist = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  @override
  Widget build(BuildContext context) {
    final checklistAsync = ref.watch(monthlyChecklistProvider(_year, _month));
    final closeAsync = ref.watch(monthlyCloseProvider(_year, _month));
    final theme = Theme.of(context);

    return FeloScaffold(
      appBar: AppBar(
        title: const Text('Validate My Month'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Month selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => setState(() {
                    if (_month == 1) { _month = 12; _year--; } else { _month--; }
                  }),
                ),
                Text(
                  DateFormat('MMMM yyyy').format(DateTime(_year, _month)),
                  style: theme.textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => setState(() {
                    if (_month == 12) { _month = 1; _year++; } else { _month++; }
                  }),
                ),
              ],
            ),
          ),

          // Status indicator
          closeAsync.when(
            data: (close) => close != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Chip(
                      label: Text(
                        close.status.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: close.status == 'locked'
                          ? Colors.green[100]
                          : close.status == 'validating'
                              ? Colors.orange[100]
                              : Colors.blue[100],
                      avatar: Icon(
                        close.status == 'locked' ? Icons.lock : Icons.edit,
                        size: 16,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 8),

          // Checklist
          Expanded(
            child: checklistAsync.when(
              data: (items) {
                if (_checklist.isEmpty) {
                  for (final item in items) {
                    _checklist[item['id'] as String] = item['completed'] as bool;
                  }
                }

                final completedCount = _checklist.values.where((v) => v).length;
                final totalCount = _checklist.length;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LinearProgressIndicator(
                        value: totalCount > 0 ? completedCount / totalCount : 0,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(
                          completedCount == totalCount ? Colors.green : Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        '$completedCount of $totalCount completed',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final id = item['id'] as String;
                          final isCompleted = _checklist[id] ?? false;

                          return FeloCard(
                            child: CheckboxListTile(
                              value: isCompleted,
                              onChanged: (value) {
                                setState(() {
                                  _checklist[id] = value ?? false;
                                });
                              },
                              title: Text(
                                item['item'] as String,
                                style: TextStyle(
                                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                                  color: isCompleted ? Colors.grey : null,
                                ),
                              ),
                              subtitle: (item['count'] as int?) != null && item['count'] > 0
                                  ? Text('${item['count']} items')
                                  : null,
                              secondary: Icon(
                                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                color: isCompleted ? Colors.green : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => FeloEmptyState(
                icon: Icons.error_outline,
                title: 'Error',
                subtitle: e.toString(),
              ),
            ),
          ),

          // Close button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _confirmClose(context),
                icon: const Icon(Icons.lock_outline),
                label: const Text('Lock This Month'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmClose(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Lock This Month?'),
        content: const Text(
          'Once locked, you cannot edit transactions for this month. '
          'Make sure everything is accurate.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Call close month API
            },
            child: const Text('Lock'),
          ),
        ],
      ),
    );
  }
}
