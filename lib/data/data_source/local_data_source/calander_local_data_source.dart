import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/calender.dart';
import 'package:injectable/injectable.dart';

abstract class CalanderLocalDataSource {
  Future<void> insertCalender({required Calender calender});

  Future<void> updateCalender({required Calender calender});

  Future<void> deleteCalender({required Calender calender});

  Stream<List<Calender>> getAllCalenderStream();
}

@LazySingleton(as: CalanderLocalDataSource)
class CalenderLocalDataSourceImpl extends CalanderLocalDataSource {
  final AppDatabase _database;

  CalenderLocalDataSourceImpl(this._database);
  @override
  Future<void> deleteCalender({required Calender calender}) async {
    await _database.calanderDao.deleteCalender(calender);
  }

  @override
  Stream<List<Calender>> getAllCalenderStream() {
    return _database.calanderDao.getAllCalanderStream();
  }

  @override
  Future<void> insertCalender({required Calender calender}) async {
    await _database.calanderDao.insertCalender(calender);
  }

  @override
  Future<void> updateCalender({required Calender calender}) async {
    await _database.calanderDao.updateCalender(calender);
  }
}
