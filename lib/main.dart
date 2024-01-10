import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/presentation/screens/main_screen.dart';
import 'package:auto_silent_app/presentation/screens/widgets/app_functions.dart';
import 'package:auto_silent_app/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
    Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  await AndroidAlarmManager.initialize();
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
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(themeContext).data,
            home: const MainScreen(),
          ),
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print("Task elecuted");
    AndroidAlarmManager.oneShot(const Duration(seconds: 5), 2, AppFunctions.printHello);
    return Future.value(true);
  });
}
