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

import '../data/data_source/floor/app_database.dart' as _i4;
import '../data/data_source/local_data_source/calendar_local_data_source.dart'
    as _i5;
import '../data/data_source/local_data_source/profile_local_data_source.dart'
    as _i7;
import '../data/data_source/local_data_source/session_local_data_source.dart'
    as _i9;
import '../data/repositories/calendar_repository_impl.dart' as _i14;
import '../data/repositories/profile_repository_impl.dart' as _i20;
import '../data/repositories/session_repository_impl.dart' as _i11;
import '../data/services/calendar_services.dart' as _i6;
import '../data/services/profile_services.dart' as _i18;
import '../data/utils/app_alarm_manager.dart' as _i3;
import '../data/utils/real_volume_manager.dart' as _i8;
import '../data/utils/shared_preferance_manager.dart' as _i16;
import '../domain/repositories/calendar_repository.dart' as _i13;
import '../domain/repositories/profile_repository.dart' as _i19;
import '../domain/repositories/session_repository.dart' as _i10;
import '../presentation/cubits/calendar_cubit/calendar_cubit.dart' as _i17;
import '../presentation/cubits/profile_cubit/profile_cubit.dart' as _i21;
import '../presentation/cubits/session_cubit/session_cubit.dart' as _i15;
import 'di_module.dart' as _i22;

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
    gh.lazySingleton<_i3.AppAlarmManger>(() => _i3.AppAlarmManagerImp());
    await gh.factoryAsync<_i4.AppDatabase>(
      () => injectableModule.getAppDatabase,
      preResolve: true,
    );
    gh.lazySingleton<_i5.CalandarLocalDataSource>(
        () => _i5.CalendarLocalDataSourceImpl(gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i6.CalendarServices>(
        () => _i6.CaneldarServiceImpl(gh<_i3.AppAlarmManger>()));
    gh.lazySingleton<_i7.ProfileLocalDataSource>(
        () => _i7.ProflieLocalDataSourceImpl(gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i8.RealVolumeManager>(() => _i8.RealVolumeManagerImpl());
    gh.lazySingleton<_i9.SessionLocalDataSource>(
        () => _i9.SessionLocalDataSourceImpl(gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i10.SessionRepository>(
        () => _i11.SessionRepositoryImpl(gh<_i9.SessionLocalDataSource>()));
    await gh.factoryAsync<_i12.SharedPreferences>(
      () => injectableModule.getSharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i13.CalendarRepository>(() => _i14.CalendarRepositoryImpl(
          gh<_i5.CalandarLocalDataSource>(),
          gh<_i6.CalendarServices>(),
        ));
    gh.factory<_i15.SessionCubit>(
        () => _i15.SessionCubit(gh<_i10.SessionRepository>()));
    gh.lazySingleton<_i16.SharedPreferanceManager>(
        () => _i16.SharedPreferenceManagerImp(gh<_i12.SharedPreferences>()));
    gh.factory<_i17.CalendarCubit>(
        () => _i17.CalendarCubit(gh<_i13.CalendarRepository>()));
    gh.lazySingleton<_i18.ProfileService>(() => _i18.ProfileServicesImpl(
          gh<_i16.SharedPreferanceManager>(),
          gh<_i8.RealVolumeManager>(),
        ));
    gh.lazySingleton<_i19.ProfileRepository>(() => _i20.ProfileRepositoryImpl(
          gh<_i7.ProfileLocalDataSource>(),
          gh<_i18.ProfileService>(),
        ));
    gh.factory<_i21.ProfileCubit>(
        () => _i21.ProfileCubit(gh<_i19.ProfileRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i22.InjectableModule {}
