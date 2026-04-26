import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

class RegionOption {
  const RegionOption({
    required this.iso2,
    required this.name,
    required this.currencyIso,
    required this.dialCode,
  });

  final String iso2;
  final String name;
  final String currencyIso;
  final String dialCode;
}

/// Universal region picker bottom sheet.
///
/// Single-select mode (used by Phase 2.1 primary region override) +
/// multi-select mode (used by "+ Add another region" + Phase 6.2
/// corridor pickers).
class RegionPickerSheet extends StatefulWidget {
  const RegionPickerSheet({
    required this.regions,
    this.initialSelected = const {},
    this.multiSelect = false,
    this.maxSelections,
    this.title = 'Pick a country',
    this.subtitle,
    super.key,
  });

  final List<RegionOption> regions;
  final Set<String> initialSelected;
  final bool multiSelect;
  final int? maxSelections;
  final String title;
  final String? subtitle;

  /// Returns: single ISO2 (single-select) OR Set<String> of ISO2 (multi).
  /// Null on cancel.
  static Future<dynamic> show({
    required BuildContext context,
    required List<RegionOption> regions,
    Set<String> initialSelected = const {},
    bool multiSelect = false,
    int? maxSelections,
    String title = 'Pick a country',
    String? subtitle,
  }) {
    return showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (_) => RegionPickerSheet(
        regions: regions,
        initialSelected: initialSelected,
        multiSelect: multiSelect,
        maxSelections: maxSelections,
        title: title,
        subtitle: subtitle,
      ),
    );
  }

  @override
  State<RegionPickerSheet> createState() => _RegionPickerSheetState();
}

class _RegionPickerSheetState extends State<RegionPickerSheet> {
  late Set<String> _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = Set<String>.from(widget.initialSelected);
  }

  List<RegionOption> get _filtered {
    if (_query.isEmpty) return widget.regions;
    final q = _query.toLowerCase();
    return widget.regions
        .where(
          (r) =>
              r.name.toLowerCase().contains(q) ||
              r.iso2.toLowerCase().contains(q),
        )
        .toList();
  }

  void _toggle(RegionOption region) {
    setState(() {
      if (widget.multiSelect) {
        if (_selected.contains(region.iso2)) {
          _selected.remove(region.iso2);
        } else {
          if (widget.maxSelections != null &&
              _selected.length >= widget.maxSelections!)
            return;
          _selected.add(region.iso2);
        }
      } else {
        Navigator.of(context).pop(region.iso2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      widget.subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Search countries',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final region = _filtered[index];
                  final selected = _selected.contains(region.iso2);
                  return ListTile(
                    onTap: () => _toggle(region),
                    leading: CircleAvatar(
                      backgroundColor: FeloColors.mintBase.withValues(
                        alpha: 0.4,
                      ),
                      child: Text(
                        region.iso2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: FeloColors.feloiTeal,
                        ),
                      ),
                    ),
                    title: Text(region.name),
                    subtitle: Text(
                      '${region.dialCode} · ${region.currencyIso}',
                    ),
                    trailing: widget.multiSelect
                        ? Icon(
                            selected
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked_rounded,
                            color: selected ? FeloColors.feloiTeal : null,
                          )
                        : const Icon(Icons.chevron_right_rounded),
                  );
                },
              ),
            ),
            if (widget.multiSelect)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(_selected),
                    child: Text('Done (${_selected.length})'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
