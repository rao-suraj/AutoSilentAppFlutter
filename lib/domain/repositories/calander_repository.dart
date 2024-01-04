import 'package:auto_silent_app/data/models/calender.dart';

abstract class CalenderRepository {
  Future<void> insertCalender({required Calender calender});

  Future<void> updateCalender({required Calender calender});

  Future<void> deleteCalender({required Calender calender});

  Stream<List<Calender>> getAllCalenderesStream();
}
