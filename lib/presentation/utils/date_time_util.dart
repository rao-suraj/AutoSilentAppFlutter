import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getFormattedDate(int time) {
    return DateFormat("dd MMM yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedTime(TimeOfDay time) {
    int hour = time.hourOfPeriod;
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  static Future<DateTime> showDialogPicker(BuildContext context) async {
    late DateTime? date;
    date = await showDatePicker(
      context: context,
      helpText: 'Your Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      return date;
    } else {
      return DateTime.now();
    }
  }

  static Future<TimeOfDay> showDialogTimePicker(BuildContext context) async {
    late TimeOfDay? time;
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );
    if (time != null) {
      return Future.value(time);
    } else {
      return TimeOfDay.now();
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}