import 'dart:async';
import 'package:auto_silent_app/data/data_source/floor/daos/calender_dao.dart';
import 'package:auto_silent_app/data/data_source/floor/daos/profile_dao.dart';
import 'package:auto_silent_app/data/data_source/floor/daos/session_dao.dart';
import 'package:auto_silent_app/data/utils/date_time_convertor.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;  //this is required for the floor

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Session,Profile,Calendar])
abstract class AppDatabase extends FloorDatabase {
  SessionDao get sessionDao;
  ProfileDao get profileDao;
  CalendarDao get calandarDao;
}
