import 'package:auto_silent_app/data/models/calander.dart';
import 'package:floor/floor.dart';

@dao
abstract class CalanderDao {
  @insert
  Future<void> insertCalander(Calander calander);

  @delete
  Future<void> deleteCalander(Calander calander);

  @update
  Future<void> updateCalander(Calander calander);

  @Query('SELECT * FROM Calander')
  Stream<List<Calander>> getAllCalanderStream();
}
