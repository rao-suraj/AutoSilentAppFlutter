import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/data/utils/alarm_manager_utils.dart';
import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/domain/utils/enums.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/screens/main_screen.dart';
import 'package:auto_silent_app/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await configureDependencies();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: AppThemes.getAppThemes(context),
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SessionCubit>()..setSession(),
                lazy: true,
              ),
              BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
                lazy: true,
              ),
              BlocProvider(
                create: (context) =>
                    getIt<CalendarCubit>()..removeExpiredCalendar(),
                lazy: true,
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.themeOf(themeContext).data,
              home: const MainScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

// this function needs to be here because its the way WorkManager functions
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    int? retryCount;
    late SharedPreferences sharedPref;
    try {
      sharedPref = await SharedPreferences.getInstance();
      retryCount = sharedPref.getInt('retryCount');
      if (retryCount == null) {
        sharedPref.setInt('retryCount', 0);
        retryCount = 0;
      }
      await AndroidAlarmManager.initialize();
      final AppDatabase database =
          await $FloorAppDatabase.databaseBuilder('auto_silent_app.db').build();

      // Get the list of sessions that needs to be activated today
      List<Session> list =
          await database.sessionDao.getSessionByDay(DayOfTheWeek.getDay());

      // Set it one by one
      if (list.isNotEmpty) {
        final now = DateTime.now();
        for (int i = 0; i < list.length; i++) {
          AndroidAlarmManager.oneShotAt(
              list[i].startTime.copyWith(
                  year: now.year,
                  month: now.month,
                  day: now.day), // replace date by todays date
              AlarmManagerUtils.getSetAlarmId(id: list[i].id),
              AlarmManagerUtils.setSilentMode,
              exact: true);
          AndroidAlarmManager.oneShotAt(
              list[i]
                  .endTime
                  .copyWith(year: now.year, month: now.month, day: now.day),
              AlarmManagerUtils.getRemoveAlarmId(id: list[i].id),
              AlarmManagerUtils.removeSilentMode,
              exact: true);
        }
      } else {
        print("Empty");
      }
      await sharedPref.setInt('retryCount', 0);
      return Future.value(true);
    } catch (e) {
      print("$e Error in initialization");
      if (retryCount! > 3) {
        await sharedPref.setInt('retryCount', 0);
        return Future.error(Exception(e.toString()));
      } else {
        await sharedPref.setInt('retryCount', retryCount + 1);
        return Future.value(false);
      }
    }
  });
}
