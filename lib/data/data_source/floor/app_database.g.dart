// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SessionDao? _sessionDaoInstance;

  ProfileDao? _profileDaoInstance;

  CalendarDao? _calandarDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Session` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `startTime` INTEGER NOT NULL, `endTime` INTEGER NOT NULL, `isActive` INTEGER NOT NULL, `sunday` INTEGER NOT NULL, `monday` INTEGER NOT NULL, `tuesday` INTEGER NOT NULL, `wednesday` INTEGER NOT NULL, `thursday` INTEGER NOT NULL, `friday` INTEGER NOT NULL, `saturday` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Profile` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `isActive` INTEGER NOT NULL, `volumeLevel` INTEGER, `ringerLevel` INTEGER, `isNetActive` INTEGER, `isDNDActive` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Calendar` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `startTime` INTEGER NOT NULL, `endTime` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL, `isActive` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SessionDao get sessionDao {
    return _sessionDaoInstance ??= _$SessionDao(database, changeListener);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  CalendarDao get calandarDao {
    return _calandarDaoInstance ??= _$CalendarDao(database, changeListener);
  }
}

class _$SessionDao extends SessionDao {
  _$SessionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _sessionInsertionAdapter = InsertionAdapter(
            database,
            'Session',
            (Session item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'isActive': item.isActive ? 1 : 0,
                  'sunday': item.sunday ? 1 : 0,
                  'monday': item.monday ? 1 : 0,
                  'tuesday': item.tuesday ? 1 : 0,
                  'wednesday': item.wednesday ? 1 : 0,
                  'thursday': item.thursday ? 1 : 0,
                  'friday': item.friday ? 1 : 0,
                  'saturday': item.saturday ? 1 : 0
                },
            changeListener),
        _sessionUpdateAdapter = UpdateAdapter(
            database,
            'Session',
            ['id'],
            (Session item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'isActive': item.isActive ? 1 : 0,
                  'sunday': item.sunday ? 1 : 0,
                  'monday': item.monday ? 1 : 0,
                  'tuesday': item.tuesday ? 1 : 0,
                  'wednesday': item.wednesday ? 1 : 0,
                  'thursday': item.thursday ? 1 : 0,
                  'friday': item.friday ? 1 : 0,
                  'saturday': item.saturday ? 1 : 0
                },
            changeListener),
        _sessionDeletionAdapter = DeletionAdapter(
            database,
            'Session',
            ['id'],
            (Session item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'isActive': item.isActive ? 1 : 0,
                  'sunday': item.sunday ? 1 : 0,
                  'monday': item.monday ? 1 : 0,
                  'tuesday': item.tuesday ? 1 : 0,
                  'wednesday': item.wednesday ? 1 : 0,
                  'thursday': item.thursday ? 1 : 0,
                  'friday': item.friday ? 1 : 0,
                  'saturday': item.saturday ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Session> _sessionInsertionAdapter;

  final UpdateAdapter<Session> _sessionUpdateAdapter;

  final DeletionAdapter<Session> _sessionDeletionAdapter;

  @override
  Stream<List<Session>> getAllSessionStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Session',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getSundaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE sunday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getMondaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE monday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getTuesdaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE tuesday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getWednesdaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE wednesday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getThursdaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE thursday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getFridaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE friday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Stream<List<Session>> getSaturdaySession(bool isTrue) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Session WHERE saturday IS ?1',
        mapper: (Map<String, Object?> row) => Session(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            isActive: (row['isActive'] as int) != 0,
            sunday: (row['sunday'] as int) != 0,
            monday: (row['monday'] as int) != 0,
            tuesday: (row['tuesday'] as int) != 0,
            wednesday: (row['wednesday'] as int) != 0,
            thursday: (row['thursday'] as int) != 0,
            friday: (row['friday'] as int) != 0,
            saturday: (row['saturday'] as int) != 0),
        arguments: [isTrue ? 1 : 0],
        queryableName: 'Session',
        isView: false);
  }

  @override
  Future<void> insertSession(Session session) async {
    await _sessionInsertionAdapter.insert(session, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSession(Session session) async {
    await _sessionUpdateAdapter.update(session, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSession(Session session) async {
    await _sessionDeletionAdapter.delete(session);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _profileInsertionAdapter = InsertionAdapter(
            database,
            'Profile',
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isActive': item.isActive ? 1 : 0,
                  'volumeLevel': item.volumeLevel,
                  'ringerLevel': item.ringerLevel,
                  'isNetActive': item.isNetActive == null
                      ? null
                      : (item.isNetActive! ? 1 : 0),
                  'isDNDActive': item.isDNDActive == null
                      ? null
                      : (item.isDNDActive! ? 1 : 0)
                },
            changeListener),
        _profileUpdateAdapter = UpdateAdapter(
            database,
            'Profile',
            ['id'],
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isActive': item.isActive ? 1 : 0,
                  'volumeLevel': item.volumeLevel,
                  'ringerLevel': item.ringerLevel,
                  'isNetActive': item.isNetActive == null
                      ? null
                      : (item.isNetActive! ? 1 : 0),
                  'isDNDActive': item.isDNDActive == null
                      ? null
                      : (item.isDNDActive! ? 1 : 0)
                },
            changeListener),
        _profileDeletionAdapter = DeletionAdapter(
            database,
            'Profile',
            ['id'],
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isActive': item.isActive ? 1 : 0,
                  'volumeLevel': item.volumeLevel,
                  'ringerLevel': item.ringerLevel,
                  'isNetActive': item.isNetActive == null
                      ? null
                      : (item.isNetActive! ? 1 : 0),
                  'isDNDActive': item.isDNDActive == null
                      ? null
                      : (item.isDNDActive! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Profile> _profileInsertionAdapter;

  final UpdateAdapter<Profile> _profileUpdateAdapter;

  final DeletionAdapter<Profile> _profileDeletionAdapter;

  @override
  Stream<List<Profile>> getAllProfileStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Profile',
        mapper: (Map<String, Object?> row) => Profile(
            id: row['id'] as int,
            title: row['title'] as String,
            isActive: (row['isActive'] as int) != 0,
            isNetActive: row['isNetActive'] == null
                ? null
                : (row['isNetActive'] as int) != 0,
            isDNDActive: row['isDNDActive'] == null
                ? null
                : (row['isDNDActive'] as int) != 0,
            volumeLevel: row['volumeLevel'] as int?,
            ringerLevel: row['ringerLevel'] as int?),
        queryableName: 'Profile',
        isView: false);
  }

  @override
  Future<void> insertProfile(Profile profile) async {
    await _profileInsertionAdapter.insert(profile, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await _profileUpdateAdapter.update(profile, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProfile(Profile profile) async {
    await _profileDeletionAdapter.delete(profile);
  }
}

class _$CalendarDao extends CalendarDao {
  _$CalendarDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _calendarInsertionAdapter = InsertionAdapter(
            database,
            'Calendar',
            (Calendar item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'isActive': item.isActive ? 1 : 0
                },
            changeListener),
        _calendarUpdateAdapter = UpdateAdapter(
            database,
            'Calendar',
            ['id'],
            (Calendar item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'isActive': item.isActive ? 1 : 0
                },
            changeListener),
        _calendarDeletionAdapter = DeletionAdapter(
            database,
            'Calendar',
            ['id'],
            (Calendar item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startTime': _dateTimeConverter.encode(item.startTime),
                  'endTime': _dateTimeConverter.encode(item.endTime),
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'isActive': item.isActive ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Calendar> _calendarInsertionAdapter;

  final UpdateAdapter<Calendar> _calendarUpdateAdapter;

  final DeletionAdapter<Calendar> _calendarDeletionAdapter;

  @override
  Stream<List<Calendar>> getAllCalandarStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Calendar',
        mapper: (Map<String, Object?> row) => Calendar(
            id: row['id'] as int,
            title: row['title'] as String,
            startTime: _dateTimeConverter.decode(row['startTime'] as int),
            endTime: _dateTimeConverter.decode(row['endTime'] as int),
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            isActive: (row['isActive'] as int) != 0),
        queryableName: 'Calendar',
        isView: false);
  }

  @override
  Future<void> insertCalendar(Calendar calandar) async {
    await _calendarInsertionAdapter.insert(calandar, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCalendar(Calendar calandar) async {
    await _calendarUpdateAdapter.update(calandar, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCalendar(Calendar calandar) async {
    await _calendarDeletionAdapter.delete(calandar);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
