// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../data/data_source/floor/app_database.dart' as _i3;
import '../data/data_source/local_data_source/calendar_local_data_source.dart'
    as _i4;
import '../data/data_source/local_data_source/profile_local_data_source.dart'
    as _i7;
import '../data/data_source/local_data_source/session_local_data_source.dart'
    as _i9;
import '../data/repositories/calendar_repository_impl.dart' as _i6;
import '../data/repositories/profile_repository_impl.dart' as _i18;
import '../data/repositories/session_repository_impl.dart' as _i11;
import '../data/services/profile_services.dart' as _i16;
import '../data/utils/real_volume_manager.dart' as _i8;
import '../data/utils/shared_preferance_manager.dart' as _i15;
import '../domain/repositories/calendar_repository.dart' as _i5;
import '../domain/repositories/profile_repository.dart' as _i17;
import '../domain/repositories/session_repository.dart' as _i10;
import '../presentation/cubits/calendar_cubit/calendar_cubit.dart' as _i13;
import '../presentation/cubits/profile_cubit/profile_cubit.dart' as _i19;
import '../presentation/cubits/session_cubit/session_cubit.dart' as _i14;
import 'di_module.dart' as _i20;

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
    gh.lazySingleton<_i7.ProfileLocalDataSource>(
        () => _i7.ProflieLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i8.RealVolumeManager>(() => _i8.RealVolumeManagerImpl());
    gh.lazySingleton<_i9.SessionLocalDataSource>(
        () => _i9.SessionLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i10.SessionRepository>(
        () => _i11.SessionRepositoryImpl(gh<_i9.SessionLocalDataSource>()));
    await gh.factoryAsync<_i12.SharedPreferences>(
      () => injectableModule.getSharedPreferences,
      preResolve: true,
    );
    gh.factory<_i13.CalendarCubit>(
        () => _i13.CalendarCubit(gh<_i5.CalendarRepository>()));
    gh.factory<_i14.SessionCubit>(
        () => _i14.SessionCubit(gh<_i10.SessionRepository>()));
    gh.lazySingleton<_i15.SharedPreferanceManager>(
        () => _i15.SharedPreferenceManagerImp(gh<_i12.SharedPreferences>()));
    gh.lazySingleton<_i16.ProfileService>(() => _i16.ProfileServicesImpl(
          gh<_i15.SharedPreferanceManager>(),
          gh<_i8.RealVolumeManager>(),
        ));
    gh.lazySingleton<_i17.ProfileRepository>(() => _i18.ProfileRepositoryImpl(
          gh<_i7.ProfileLocalDataSource>(),
          gh<_i16.ProfileService>(),
        ));
    gh.factory<_i19.ProfileCubit>(
        () => _i19.ProfileCubit(gh<_i17.ProfileRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i20.InjectableModule {}
