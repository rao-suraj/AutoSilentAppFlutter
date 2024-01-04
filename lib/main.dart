import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/screens/main_screen.dart';
import 'package:auto_silent_app/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
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
            home: BlocProvider<CalendarsCubit>(
              create: (_) => getIt<CalendarsCubit>()..getProfileStream(),
              child:const MainScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
