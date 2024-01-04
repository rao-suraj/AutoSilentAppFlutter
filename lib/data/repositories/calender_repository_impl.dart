import 'package:auto_silent_app/data/data_source/local_data_source/calander_local_data_source.dart';
import 'package:auto_silent_app/data/models/calender.dart';
import 'package:auto_silent_app/domain/repositories/calander_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CalenderRepository)
class CalenderRepositoryImpl extends CalenderRepository {
  final CalenderLocalDataSourceImpl _calenderLocalDataSource;

  CalenderRepositoryImpl(this._calenderLocalDataSource);
  @override
  Future<void> deleteCalender({required Calender calender}) async {
    await _calenderLocalDataSource.deleteCalender(calender: calender);
  }

  @override
  Future<void> insertCalender({required Calender calender}) async {
    await _calenderLocalDataSource.insertCalender(calender: calender);
  }

  @override
  Future<void> updateCalender({required Calender calender}) async {
    await _calenderLocalDataSource.updateCalender(calender: calender);
  }

  @override
  Stream<List<Calender>> getAllCalenderesStream() {
    return _calenderLocalDataSource.getAllCalenderStream();
  }
}
