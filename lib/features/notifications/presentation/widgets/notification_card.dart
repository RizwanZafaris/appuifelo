import 'package:flutter/material.dart';

import 'package:felo/shared/widgets/felo_card.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.title,
    required this.body,
    required this.timestamp,
    required this.categoryLabel,
    required this.icon,
    required this.isRead,
    super.key,
    this.markReadLabel,
    this.onMarkRead,
  });

  final String title;
  final String body;
  final String timestamp;
  final String categoryLabel;
  final IconData icon;
  final bool isRead;
  final String? markReadLabel;
  final VoidCallback? onMarkRead;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FeloCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: colors.onPrimaryContainer),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (!isRead) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      body,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Chip(
                label: Text(categoryLabel),
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: colors.outlineVariant),
              ),
              Chip(
                label: Text(timestamp),
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: colors.outlineVariant),
              ),
            ],
          ),
          if (!isRead && onMarkRead != null && markReadLabel != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: onMarkRead,
                child: Text(markReadLabel!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
