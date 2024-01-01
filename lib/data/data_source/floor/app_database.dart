import 'dart:async';
import 'package:auto_silent_app/data/data_source/floor/daos/calander_dao.dart';
import 'package:auto_silent_app/data/data_source/floor/daos/profile_dao.dart';
import 'package:auto_silent_app/data/data_source/floor/daos/session_dao.dart';
import 'package:auto_silent_app/data/data_source/floor/date_time_convertor.dart';
import 'package:auto_silent_app/data/models/calander.dart';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;  //this is required for the floor

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Session,Profile,Calander])
abstract class AppDatabase extends FloorDatabase {
  SessionDao get sessionDao;
  ProfileDao get profileDao;
  CalanderDao get calanderDao;
}
