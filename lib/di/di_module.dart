
import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModule {
  @preResolve
  Future<AppDatabase>  get getAppDatabase => $FloorAppDatabase.databaseBuilder('auto_silent_app.db').build();
}