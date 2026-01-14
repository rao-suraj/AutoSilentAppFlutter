import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_silent_app_flutter/presentation/screens/widgets/time_display.dart';

void main() {
  testWidgets('TimeDisplay shows given time', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TimeDisplay(time: '09:30'),
        ),
      ),
    );

    expect(find.text('09:30'), findsOneWidget);
  });
}
