import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/design/stitch_screen_registry.dart';

void main() {
  test('Stitch export screen registry covers every design screen', () {
    expect(stitchScreenIds, hasLength(184));
    expect(stitchScreenIds.toSet(), hasLength(stitchScreenIds.length));
    expect(stitchScreenById('home_dashboard_1'), isNotNull);
    expect(stitchScreenById('virtual_card_intro_2'), isNotNull);
  });
}
