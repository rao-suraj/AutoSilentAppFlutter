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
    as _i8;
import '../data/data_source/local_data_source/session_local_data_source.dart'
    as _i10;
import '../data/repositories/calendar_repository_impl.dart' as _i14;
import '../data/repositories/permission_repository_impl.dart' as _i16;
import '../data/repositories/profile_repository_impl.dart' as _i25;
import '../data/repositories/session_repository_impl.dart' as _i18;
import '../data/services/calendar_services.dart' as _i6;
import '../data/services/permission_services.dart' as _i7;
import '../data/services/profile_services.dart' as _i22;
import '../data/services/session_services.dart' as _i11;
import '../data/utils/app_alarm_manager.dart' as _i3;
import '../data/utils/real_volume_manager.dart' as _i9;
import '../data/utils/shared_preferance_manager.dart' as _i19;
import '../domain/repositories/calendar_repository.dart' as _i13;
import '../domain/repositories/permission_repository.dart' as _i15;
import '../domain/repositories/profile_repository.dart' as _i24;
import '../domain/repositories/session_repository.dart' as _i17;
import '../presentation/cubits/calendar_cubit/calendar_cubit.dart' as _i20;
import '../presentation/cubits/permission_cubit/permission_cubit.dart' as _i21;
import '../presentation/cubits/profile_cubit/profile_cubit.dart' as _i26;
import '../presentation/cubits/session_cubit/session_cubit.dart' as _i23;
import 'di_module.dart' as _i27;

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
    gh.lazySingleton<_i7.PermissionServices>(
        () => _i7.PermissionServicesImpl());
    gh.lazySingleton<_i8.ProfileLocalDataSource>(
        () => _i8.ProflieLocalDataSourceImpl(gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i9.RealVolumeManager>(() => _i9.RealVolumeManagerImpl());
    gh.lazySingleton<_i10.SessionLocalDataSource>(
        () => _i10.SessionLocalDataSourceImpl(gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i11.SessionServices>(
        () => _i11.SessionServiceImpl(gh<_i3.AppAlarmManger>()));
    await gh.factoryAsync<_i12.SharedPreferences>(
      () => injectableModule.getSharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i13.CalendarRepository>(() => _i14.CalendarRepositoryImpl(
          gh<_i5.CalandarLocalDataSource>(),
          gh<_i6.CalendarServices>(),
        ));
    gh.lazySingleton<_i15.PermissionRepository>(
        () => _i16.PermissionRepositoryImpl(gh<_i7.PermissionServices>()));
    gh.lazySingleton<_i17.SessionRepository>(() => _i18.SessionRepositoryImpl(
          gh<_i10.SessionLocalDataSource>(),
          gh<_i11.SessionServices>(),
        ));
    gh.lazySingleton<_i19.SharedPreferanceManager>(
        () => _i19.SharedPreferenceManagerImp(gh<_i12.SharedPreferences>()));
    gh.factory<_i20.CalendarCubit>(
        () => _i20.CalendarCubit(gh<_i13.CalendarRepository>()));
    gh.factory<_i21.PermissionCubit>(
        () => _i21.PermissionCubit(gh<_i15.PermissionRepository>()));
    gh.lazySingleton<_i22.ProfileService>(() => _i22.ProfileServicesImpl(
          gh<_i19.SharedPreferanceManager>(),
          gh<_i9.RealVolumeManager>(),
        ));
    gh.factory<_i23.SessionCubit>(
        () => _i23.SessionCubit(gh<_i17.SessionRepository>()));
    gh.lazySingleton<_i24.ProfileRepository>(() => _i25.ProfileRepositoryImpl(
          gh<_i8.ProfileLocalDataSource>(),
          gh<_i22.ProfileService>(),
        ));
    gh.factory<_i26.ProfileCubit>(
        () => _i26.ProfileCubit(gh<_i24.ProfileRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i27.InjectableModule {}
