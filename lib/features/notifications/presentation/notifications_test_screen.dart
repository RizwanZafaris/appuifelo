import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/notifications/data/live_notifications_service.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

/// Debug-only screen that fires a notification through the live backend.
/// Visible only in debug builds (`kDebugMode`); the backend additionally
/// returns 403 in production for the same endpoint, so this UI is safe.
class NotificationsTestScreen extends ConsumerStatefulWidget {
  const NotificationsTestScreen({super.key});

  @override
  ConsumerState<NotificationsTestScreen> createState() =>
      _NotificationsTestScreenState();
}

class _NotificationsTestScreenState
    extends ConsumerState<NotificationsTestScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _busy = false;
  String? _result;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = context.l10n;
    setState(() {
      _busy = true;
      _result = null;
    });
    try {
      await ref.read(liveNotificationsServiceProvider.notifier).sendTest(
            title: _titleController.text.trim().isEmpty
                ? l10n.notificationsTestDefaultTitle
                : _titleController.text.trim(),
            body: _bodyController.text.trim().isEmpty
                ? l10n.notificationsTestDefaultBody
                : _bodyController.text.trim(),
          );
      if (!mounted) return;
      setState(() => _result = l10n.notificationsTestSent);
    } catch (err) {
      if (!mounted) return;
      setState(() => _result = '$err');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (!kDebugMode) {
      // In release builds we redirect away; backend also blocks.
      return FeloScaffold(
        title: l10n.notificationsTestTitle,
        selectedTab: FeloRootTab.home,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FeloCard(
              child: Column(
                children: [
                  const Icon(Icons.lock_outline_rounded, size: 36),
                  const SizedBox(height: 12),
                  Text(l10n.notificationsTestProdDisabled, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  FeloButton(
                    label: l10n.commonContinue,
                    onPressed: () => context.go('/notifications'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return FeloScaffold(
      title: l10n.notificationsTestTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.notificationsTestBlurb,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          FeloCard(
            child: Column(
              children: [
                FeloInput(
                  label: l10n.notificationsTestTitleLabel,
                  controller: _titleController,
                ),
                const SizedBox(height: 12),
                FeloInput(
                  label: l10n.notificationsTestBodyLabel,
                  controller: _bodyController,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FeloButton(
            label: _busy ? l10n.commonContinue : l10n.notificationsTestSend,
            onPressed: _busy ? null : _send,
          ),
          if (_result != null) ...[
            const SizedBox(height: 12),
            FeloCard(
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded),
                  const SizedBox(width: 12),
                  Expanded(child: Text(_result!)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
