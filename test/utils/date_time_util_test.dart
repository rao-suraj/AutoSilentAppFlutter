import 'package:flutter_test/flutter_test.dart';
import 'package:auto_silent_app_flutter/presentation/utils/date_time_util.dart';

void main() {
  group('DateTimeUtil', () {
    test('formatTime returns HH:mm', () {
      final dt = DateTime(2024, 1, 1, 9, 5);

      final result = DateTimeUtil.formatTime(dt);

      expect(result, '09:05');
    });

    test('formatDate returns correct format', () {
      final dt = DateTime(2024, 1, 2);

      final result = DateTimeUtil.formatDate(dt);

      expect(result, '02 Jan 2024');
    });
  });
}
