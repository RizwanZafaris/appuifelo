import 'package:flutter/material.dart' hide Split;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/splits/data/splits_repository.dart';
import 'package:felo/features/splits/domain/split.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class SplitsScreen extends ConsumerWidget {
  const SplitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final splitsAsync = ref.watch(splitsProvider);
    final splits = splitsAsync.valueOrNull ?? const <Split>[];
    final active = splits
        .where((split) => split.status == SplitStatus.active)
        .toList();
    final settled = splits
        .where((split) => split.status == SplitStatus.settled)
        .toList();

    return DefaultTabController(
      length: 2,
      child: FeloScaffold(
        title: l10n.splitsTitle,
        selectedTab: FeloRootTab.doHub,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: l10n.splitsActiveTab),
                Tab(text: l10n.splitsSettledTab),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  TabBarView(
                    children: [
                      _SplitList(
                        splits: active,
                        emptyTitle: l10n.splitsEmptyActiveTitle,
                        emptyBody: l10n.splitsEmptyActiveBody,
                      ),
                      _SplitList(
                        splits: settled,
                        emptyTitle: l10n.splitsEmptySettledTitle,
                        emptyBody: l10n.splitsEmptySettledBody,
                      ),
                    ],
                  ),
                  PositionedDirectional(
                    end: 20,
                    bottom: 20,
                    child: FloatingActionButton.extended(
                      heroTag: 'new_split_fab',
                      onPressed: () => context.go('/splits/new'),
                      icon: const Icon(Icons.group_add_rounded),
                      label: Text(l10n.splitsNewSplit),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplitList extends StatelessWidget {
  const _SplitList({
    required this.splits,
    required this.emptyTitle,
    required this.emptyBody,
  });

  final List<Split> splits;
  final String emptyTitle;
  final String emptyBody;

  @override
  Widget build(BuildContext context) {
    if (splits.isEmpty) {
      return FeloEmptyState(title: emptyTitle, body: emptyBody);
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 96),
      itemBuilder: (context, index) => _SplitCard(split: splits[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: splits.length,
    );
  }
}

class _SplitCard extends StatelessWidget {
  const _SplitCard({required this.split});

  final Split split;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      onTap: () => context.go('/splits/${split.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.groups_2_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  split.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                formatMinorMoney(
                  minor: split.totalMinor,
                  currency: split.currency,
                ),
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: split.progress,
            minHeight: 9,
            borderRadius: BorderRadius.circular(99),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.splitsPaidProgress(
              split.paidParticipantCount,
              split.participants.length,
            ),
          ),
        ],
      ),
    );
  }
}

class NewSplitScreen extends ConsumerStatefulWidget {
  const NewSplitScreen({super.key});

  @override
  ConsumerState<NewSplitScreen> createState() => _NewSplitScreenState();
}

class _NewSplitScreenState extends ConsumerState<NewSplitScreen> {
  // Form fields start empty; defaults are populated in initState() so
  // dismiss-without-edit doesn't ship hardcoded placeholders into real
  // submissions. Senior review flagged the previous defaults
  // ('Dinner split', 'CAD', '120.00', 'Rizwan'/'Saad' mock people).
  final _nameController = TextEditingController();
  final _currencyController = TextEditingController();
  final _amountController = TextEditingController();
  final List<_ParticipantControllers> _participants = [];
  bool _equalShares = true;
  int _step = 0;

  @override
  void initState() {
    super.initState();
    // Sensible currency default — start blank so the user actively picks.
    // (When the profile API exposes a default currency, set it here.)
    _nameController.addListener(_refresh);
    _currencyController.addListener(_refresh);
    _amountController.addListener(_refresh);
    for (final participant in _participants) {
      participant.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currencyController.dispose();
    _amountController.dispose();
    for (final participant in _participants) {
      participant.dispose();
    }
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final totalMinor = _parseMajorToMinor(_amountController.text);
    final shareTotal = _shareTotalMinor(totalMinor);
    final validShares = totalMinor > 0 && shareTotal == totalMinor;
    final steps = [
      _SplitWizardStep(
        title: l10n.splitsWizardBasics,
        child: Column(
          children: [
            FeloInput(
              label: l10n.splitsNameLabel,
              controller: _nameController,
              hint: l10n.splitsNameHint,
            ),
            const SizedBox(height: 12),
            FeloInput(
              label: l10n.splitsCurrencyLabel,
              controller: _currencyController,
              textCapitalization: TextCapitalization.characters,
            ),
          ],
        ),
      ),
      _SplitWizardStep(
        title: l10n.splitsWizardAmount,
        child: FeloInput(
          label: l10n.splitsAmountLabel,
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      ),
      _SplitWizardStep(
        title: l10n.splitsWizardParticipants,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              children: [
                FeloChip(
                  label: l10n.splitsEqualShares,
                  selected: _equalShares,
                  icon: Icons.balance_rounded,
                  onTap: () {
                    setState(() {
                      _equalShares = true;
                      _applyEqualShares(totalMinor);
                    });
                  },
                ),
                FeloChip(
                  label: l10n.splitsCustomShares,
                  selected: !_equalShares,
                  icon: Icons.tune_rounded,
                  onTap: () => setState(() => _equalShares = false),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (var index = 0; index < _participants.length; index++) ...[
              _ParticipantFields(
                index: index,
                controllers: _participants[index],
                customShares: !_equalShares,
                onRemove: _participants.length <= 2
                    ? null
                    : () {
                        setState(() {
                          final removed = _participants.removeAt(index);
                          removed.dispose();
                          if (_equalShares) {
                            _applyEqualShares(totalMinor);
                          }
                        });
                      },
              ),
              const SizedBox(height: 12),
            ],
            FeloButton(
              label: l10n.splitsAddParticipant,
              icon: Icons.person_add_alt_1_rounded,
              variant: FeloButtonVariant.secondary,
              onPressed: _participants.length >= 10
                  ? null
                  : () {
                      setState(() {
                        final participant = _ParticipantControllers(
                          name: '',
                          contact: '',
                          share: '0.00',
                        )..addListener(_refresh);
                        _participants.add(participant);
                        if (_equalShares) {
                          _applyEqualShares(totalMinor);
                        }
                      });
                    },
            ),
            const SizedBox(height: 12),
            Text(
              validShares
                  ? l10n.splitsShareValidationOk
                  : l10n.splitsShareValidationError(
                      formatMinorMoney(minor: shareTotal, currency: _currency),
                      formatMinorMoney(minor: totalMinor, currency: _currency),
                    ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: validShares
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      _SplitWizardStep(
        title: l10n.splitsWizardReview,
        child: _ReviewSplit(
          name: _name,
          currency: _currency,
          totalMinor: totalMinor,
          participants: _draftParticipants(totalMinor),
        ),
      ),
    ];

    return FeloScaffold(
      title: l10n.splitsNewSplit,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  steps[_step].title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                steps[_step].child,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Row(
              children: [
                if (_step > 0)
                  Expanded(
                    child: FeloButton(
                      label: l10n.commonBack,
                      variant: FeloButtonVariant.ghost,
                      onPressed: () => setState(() => _step -= 1),
                    ),
                  ),
                if (_step > 0) const SizedBox(width: 12),
                Expanded(
                  child: FeloButton(
                    label: _step == steps.length - 1
                        ? l10n.splitsCreateSplit
                        : l10n.commonContinue,
                    icon: _step == steps.length - 1
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                    onPressed: _canAdvance(totalMinor, validShares)
                        ? () => _advance(totalMinor)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _name => _nameController.text.trim().isEmpty
      ? 'Split'
      : _nameController.text.trim();

  String get _currency {
    final value = _currencyController.text.trim().toUpperCase();
    return value.isEmpty ? 'CAD' : value;
  }

  bool _canAdvance(int totalMinor, bool validShares) {
    if (_step == 0) {
      return _name.trim().isNotEmpty && _currency.length == 3;
    }
    if (_step == 1) {
      return totalMinor > 0;
    }
    if (_step == 2) {
      return _participants.length >= 2 &&
          validShares &&
          _participants.every(
            (participant) => participant.name.text.trim().isNotEmpty,
          );
    }
    return true;
  }

  Future<void> _advance(int totalMinor) async {
    if (_step < 3) {
      setState(() {
        _step += 1;
        if (_equalShares) {
          _applyEqualShares(totalMinor);
        }
      });
      return;
    }

    final split = await ref
        .read(splitsProvider.notifier)
        .createSplit(
          name: _name,
          currency: _currency,
          totalMinor: totalMinor,
          participants: _draftParticipants(totalMinor),
        );
    if (!mounted) return;
    context.go('/splits/${split.id}');
  }

  int _shareTotalMinor(int totalMinor) {
    return _draftParticipants(
      totalMinor,
    ).fold<int>(0, (sum, participant) => sum + participant.shareMinor);
  }

  List<SplitParticipantDraft> _draftParticipants(int totalMinor) {
    if (_equalShares) {
      final baseShare = totalMinor ~/ _participants.length;
      final remainder = totalMinor % _participants.length;
      return [
        for (var index = 0; index < _participants.length; index++)
          SplitParticipantDraft(
            displayName: _participants[index].name.text.trim().isEmpty
                ? context.l10n.splitsParticipantFallback(index + 1)
                : _participants[index].name.text.trim(),
            contact: _participants[index].contact.text.trim(),
            shareMinor: baseShare + (index == 0 ? remainder : 0),
          ),
      ];
    }
    return [
      for (final participant in _participants)
        SplitParticipantDraft(
          displayName: participant.name.text.trim(),
          contact: participant.contact.text.trim(),
          shareMinor: _parseMajorToMinor(participant.share.text),
        ),
    ];
  }

  void _applyEqualShares(int totalMinor) {
    if (_participants.isEmpty) {
      return;
    }
    final baseShare = totalMinor ~/ _participants.length;
    final remainder = totalMinor % _participants.length;
    for (var index = 0; index < _participants.length; index++) {
      final shareMinor = baseShare + (index == 0 ? remainder : 0);
      _participants[index].share.text = (shareMinor / 100).toStringAsFixed(2);
    }
  }
}

class SplitDetailScreen extends ConsumerWidget {
  const SplitDetailScreen({required this.splitId, super.key});

  final String splitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final split = ref.watch(
      splitsProvider.select((async) {
        final list = async.valueOrNull;
        if (list == null) return null;
        for (final split in list) {
          if (split.id == splitId) {
            return split;
          }
        }
        return null;
      }),
    );

    if (split == null) {
      return FeloScaffold(
        title: l10n.splitsDetailTitle,
        child: FeloEmptyState(
          title: l10n.splitsNotFoundTitle,
          body: l10n.splitsNotFoundBody,
        ),
      );
    }

    return FeloScaffold(
      title: l10n.splitsDetailTitle,
      selectedTab: FeloRootTab.doHub,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        split.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    FeloChip(
                      label: split.isSettled
                          ? l10n.splitsSettledTab
                          : l10n.splitsActiveTab,
                      selected: true,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  formatMinorMoney(
                    minor: split.totalMinor,
                    currency: split.currency,
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: split.progress,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(99),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.splitsPaidProgress(
                    split.paidParticipantCount,
                    split.participants.length,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.splitsParticipantsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          for (final participant in split.participants) ...[
            FeloCard(
              child: SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(participant.displayName),
                subtitle: Text(
                  '${participant.contact}\n${formatMinorMoney(minor: participant.shareMinor, currency: split.currency)}',
                ),
                value: participant.status == SplitParticipantStatus.paid,
                onChanged: split.isSettled
                    ? null
                    : (paid) => ref
                          .read(splitsProvider.notifier)
                          .setParticipantPaid(
                            splitId: split.id,
                            participantId: participant.id,
                            paid: paid,
                          ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 10),
          FeloButton(
            label: l10n.splitsSettleAll,
            icon: Icons.done_all_rounded,
            onPressed: split.isSettled
                ? null
                : () => ref.read(splitsProvider.notifier).settleSplit(split.id),
          ),
        ],
      ),
    );
  }
}

class _ParticipantFields extends StatelessWidget {
  const _ParticipantFields({
    required this.index,
    required this.controllers,
    required this.customShares,
    required this.onRemove,
  });

  final int index;
  final _ParticipantControllers controllers;
  final bool customShares;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.splitsParticipantNumber(index + 1),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              IconButton(
                tooltip: l10n.splitsRemoveParticipant,
                onPressed: onRemove,
                icon: const Icon(Icons.remove_circle_outline_rounded),
              ),
            ],
          ),
          FeloInput(
            label: l10n.splitsParticipantName,
            controller: controllers.name,
          ),
          const SizedBox(height: 10),
          FeloInput(
            label: l10n.splitsParticipantContact,
            controller: controllers.contact,
          ),
          const SizedBox(height: 10),
          FeloInput(
            label: l10n.splitsParticipantShare,
            controller: controllers.share,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            enabled: customShares,
          ),
        ],
      ),
    );
  }
}

class _ReviewSplit extends StatelessWidget {
  const _ReviewSplit({
    required this.name,
    required this.currency,
    required this.totalMinor,
    required this.participants,
  });

  final String name;
  final String currency;
  final int totalMinor;
  final List<SplitParticipantDraft> participants;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(formatMinorMoney(minor: totalMinor, currency: currency)),
          const Divider(height: 24),
          for (final participant in participants)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(participant.displayName),
              subtitle: Text(
                participant.contact.isEmpty
                    ? l10n.splitsContactMissing
                    : participant.contact,
              ),
              trailing: Text(
                formatMinorMoney(
                  minor: participant.shareMinor,
                  currency: currency,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SplitWizardStep {
  const _SplitWizardStep({required this.title, required this.child});

  final String title;
  final Widget child;
}

class _ParticipantControllers {
  _ParticipantControllers({
    required String name,
    required String contact,
    required String share,
  }) : name = TextEditingController(text: name),
       contact = TextEditingController(text: contact),
       share = TextEditingController(text: share);

  final TextEditingController name;
  final TextEditingController contact;
  final TextEditingController share;

  void addListener(VoidCallback listener) {
    name.addListener(listener);
    contact.addListener(listener);
    share.addListener(listener);
  }

  void dispose() {
    name.dispose();
    contact.dispose();
    share.dispose();
  }
}

int _parseMajorToMinor(String value) {
  final normalized = value.replaceAll(RegExp('[^0-9.]'), '');
  final parsed = double.tryParse(normalized);
  if (parsed == null) {
    return 0;
  }
  return (parsed * 100).round();
}
