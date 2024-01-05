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
import '../data/data_source/local_data_source/calendar_local_data_source.dart'
    as _i4;
import '../data/data_source/local_data_source/profile_local_data_source.dart'
    as _i8;
import '../data/data_source/local_data_source/session_local_data_source.dart'
    as _i11;
import '../data/repositories/calendar_repository_impl.dart' as _i6;
import '../data/repositories/profile_repository_impl.dart' as _i10;
import '../data/repositories/session_repository_impl.dart' as _i13;
import '../domain/repositories/calendar_repository.dart' as _i5;
import '../domain/repositories/profile_repository.dart' as _i9;
import '../domain/repositories/session_repository.dart' as _i12;
import '../presentation/cubits/calendar_cubit/calendar_cubit.dart' as _i7;
import '../presentation/cubits/profile_cubit/profile_cubit.dart' as _i14;
import '../presentation/cubits/session_cubit/session_cubit.dart' as _i15;
import 'di_module.dart' as _i16;

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
    gh.lazySingleton<_i4.CalandarLocalDataSource>(
        () => _i4.CalendarLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i5.CalendarRepository>(
        () => _i6.CalendarRepositoryImpl(gh<_i4.CalandarLocalDataSource>()));
    gh.factory<_i7.CalendarsCubit>(
        () => _i7.CalendarsCubit(gh<_i5.CalendarRepository>()));
    gh.lazySingleton<_i8.ProfileLocalDataSource>(
        () => _i8.ProflieLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i9.ProfileRepository>(
        () => _i10.ProfileRepositoryImpl(gh<_i8.ProfileLocalDataSource>()));
    gh.lazySingleton<_i11.SessionLocalDataSource>(
        () => _i11.SessionLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i12.SessionRepository>(
        () => _i13.SessionRepositoryImpl(gh<_i11.SessionLocalDataSource>()));
    gh.factory<_i14.ProfileCubit>(
        () => _i14.ProfileCubit(gh<_i9.ProfileRepository>()));
    gh.factory<_i15.SessionCubit>(
        () => _i15.SessionCubit(gh<_i12.SessionRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i16.InjectableModule {}
