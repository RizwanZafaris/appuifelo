import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class ExportControlScreen extends ConsumerStatefulWidget {
  const ExportControlScreen({super.key});

  @override
  ConsumerState<ExportControlScreen> createState() => _ExportControlScreenState();
}

class _ExportControlScreenState extends ConsumerState<ExportControlScreen> {
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Data'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Data Export Section
          Text('Export Your Data', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Download a copy of all your financial data. Files expire after 7 days.',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          FeloCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.download, color: Colors.blue),
                  title: const Text('Export as JSON'),
                  subtitle: const Text('Machine-readable format'),
                  trailing: _isExporting
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.chevron_right),
                  onTap: () => _requestExport('json'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.table_chart, color: Colors.green),
                  title: const Text('Export as CSV'),
                  subtitle: const Text('Spreadsheet format'),
                  trailing: _isExporting
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.chevron_right),
                  onTap: () => _requestExport('csv'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Privacy Section
          Text('Privacy Center', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Felo does not sell your data. You are in control.',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          FeloCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.visibility, color: Colors.purple),
                  title: const Text('What Felo Knows'),
                  subtitle: const Text('See what data we have about you'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showDataOverview(context),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.orange),
                  title: const Text('Activity Log'),
                  subtitle: const Text('Recent account activity'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.policy, color: Colors.teal),
                  title: const Text('Privacy Policy'),
                  subtitle: const Text('How we handle your data'),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Danger Zone
          Text('Danger Zone', style: theme.textTheme.titleLarge?.copyWith(color: Colors.red)),
          const SizedBox(height: 8),
          Text(
            'These actions are irreversible. Please proceed with caution.',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          FeloCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Delete All Data', style: TextStyle(color: Colors.red)),
                  subtitle: const Text('Permanently delete all your financial records'),
                  onTap: () => _confirmDeleteData(context),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                  subtitle: const Text('Permanently delete your Felo account'),
                  onTap: () => _confirmDeleteAccount(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _requestExport(String format) {
    setState(() => _isExporting = true);
    // TODO: Call export API
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isExporting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export requested. You will be notified when ready.')),
      );
    });
  }

  void _showDataOverview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const _DataOverviewSheet(),
    );
  }

  void _confirmDeleteData(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete All Data?'),
        content: const Text(
          'This will permanently delete all your transactions, budgets, goals, and bills. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Call delete API
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data has been deleted.')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text(
          'This will permanently delete your Felo account and all associated data. '
          'You will need to sign up again to use Felo. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Call delete account API
            },
            child: const Text('Delete Account', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _DataOverviewSheet extends StatelessWidget {
  const _DataOverviewSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dataTypes = [
      {'name': 'Transactions', 'description': 'Your logged expenses and income', 'icon': Icons.receipt_long},
      {'name': 'Budgets', 'description': 'Category spending limits', 'icon': Icons.account_balance_wallet},
      {'name': 'Goals', 'description': 'Savings targets', 'icon': Icons.flag},
      {'name': 'Bills', 'description': 'Recurring bill reminders', 'icon': Icons.calendar_today},
      {'name': 'Accounts', 'description': 'Connected bank accounts', 'icon': Icons.account_balance},
      {'name': 'Splits', 'description': 'Shared expense records', 'icon': Icons.people},
      {'name': 'Profile', 'description': 'Name, email, preferences', 'icon': Icons.person},
      {'name': 'Coach History', 'description': 'AI conversation history', 'icon': Icons.smart_toy},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What Felo Knows', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Felo stores the minimum data needed to help you track your finances. '
            'We never sell your data.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          ...dataTypes.map((d) => ListTile(
            leading: Icon(d['icon'] as IconData),
            title: Text(d['name'] as String),
            subtitle: Text(d['description'] as String),
          )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
