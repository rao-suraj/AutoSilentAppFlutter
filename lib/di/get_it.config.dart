// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/floor/app_database.dart' as _i3;
import '../data/data_source/local_data_source/profile_local_data_source.dart'
    as _i4;
import '../data/data_source/local_data_source/session_local_data_source.dart'
    as _i7;
import '../data/repositories/profile_repository_impl.dart' as _i6;
import '../data/repositories/session_repository_impl.dart' as _i9;
import '../domain/repositories/profile_repository.dart' as _i5;
import '../domain/repositories/session_repository.dart' as _i8;
import 'di_module.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    await gh.factoryAsync<_i3.AppDatabase>(
      () => injectableModule.getAppDatabase,
      preResolve: true,
    );
    gh.lazySingleton<_i4.ProfileLocalDataSource>(
        () => _i4.ProflieLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i5.ProfileRepository>(
        () => _i6.ProfileRepositoryImpl(gh<_i4.ProfileLocalDataSource>()));
    gh.lazySingleton<_i7.SessionLocalDataSource>(
        () => _i7.SessionLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i8.SessionRepository>(
        () => _i9.SessionRepositoryImpl(gh<_i7.SessionLocalDataSource>()));
    return this;
  }
}

class _$InjectableModule extends _i10.InjectableModule {}
