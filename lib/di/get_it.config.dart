// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../data/data_source/floor/app_database.dart' as _i3;
import '../data/data_source/local_data_source/calendar_local_data_source.dart'
    as _i4;
import '../data/data_source/local_data_source/profile_local_data_source.dart'
    as _i5;
import '../data/data_source/local_data_source/session_local_data_source.dart'
    as _i7;
import '../data/repositories/calendar_repository_impl.dart' as _i16;
import '../data/repositories/profile_repository_impl.dart' as _i20;
import '../data/repositories/session_repository_impl.dart' as _i9;
import '../data/services/calendar_services.dart' as _i12;
import '../data/services/profile_services.dart' as _i17;
import '../data/utils/app_alarm_manager_utils.dart' as _i11;
import '../data/utils/real_volume_manager.dart' as _i6;
import '../data/utils/shared_preferance_manager.dart' as _i14;
import '../domain/repositories/calendar_repository.dart' as _i15;
import '../domain/repositories/profile_repository.dart' as _i19;
import '../domain/repositories/session_repository.dart' as _i8;
import '../presentation/cubits/calendar_cubit/calendar_cubit.dart' as _i18;
import '../presentation/cubits/profile_cubit/profile_cubit.dart' as _i21;
import '../presentation/cubits/session_cubit/session_cubit.dart' as _i13;
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
    await gh.factoryAsync<_i3.AppDatabase>(
      () => injectableModule.getAppDatabase,
      preResolve: true,
    );
    gh.lazySingleton<_i4.CalandarLocalDataSource>(
        () => _i4.CalendarLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i5.ProfileLocalDataSource>(
        () => _i5.ProflieLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i6.RealVolumeManager>(() => _i6.RealVolumeManagerImpl());
    gh.lazySingleton<_i7.SessionLocalDataSource>(
        () => _i7.SessionLocalDataSourceImpl(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i8.SessionRepository>(
        () => _i9.SessionRepositoryImpl(gh<_i7.SessionLocalDataSource>()));
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => injectableModule.getSharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i11.AppAlarmManger>(
        () => _i11.AppAlarmManagerImp(gh<_i6.RealVolumeManager>()));
    gh.lazySingleton<_i12.CalendarServices>(
        () => _i12.CaneldarServiceImpl(gh<_i11.AppAlarmManger>()));
    gh.factory<_i13.SessionCubit>(
        () => _i13.SessionCubit(gh<_i8.SessionRepository>()));
    gh.lazySingleton<_i14.SharedPreferanceManager>(
        () => _i14.SharedPreferenceManagerImp(gh<_i10.SharedPreferences>()));
    gh.lazySingleton<_i15.CalendarRepository>(() => _i16.CalendarRepositoryImpl(
          gh<_i4.CalandarLocalDataSource>(),
          gh<_i12.CalendarServices>(),
        ));
    gh.lazySingleton<_i17.ProfileService>(() => _i17.ProfileServicesImpl(
          gh<_i14.SharedPreferanceManager>(),
          gh<_i6.RealVolumeManager>(),
        ));
    gh.factory<_i18.CalendarCubit>(
        () => _i18.CalendarCubit(gh<_i15.CalendarRepository>()));
    gh.lazySingleton<_i19.ProfileRepository>(() => _i20.ProfileRepositoryImpl(
          gh<_i5.ProfileLocalDataSource>(),
          gh<_i17.ProfileService>(),
        ));
    gh.factory<_i21.ProfileCubit>(
        () => _i21.ProfileCubit(gh<_i19.ProfileRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i22.InjectableModule {}
