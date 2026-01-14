import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_silent_app_flutter/presentation/screens/widgets/custom_switch.dart';

void main() {
  testWidgets('CustomSwitch toggles when tapped', (tester) async {
    bool value = false;

    await tester.pumpWidget(
      MaterialApp(
        home: CustomSwitch(
          value: value,
          onChanged: (v) => value = v,
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(value, true);
  });
}
