import 'package:auto_silent_app/presentation/screens/main_screen.dart';
import 'package:auto_silent_app/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
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
          builder:(themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(themeContext).data,
            home:const MainScreen()
          ),
        ),
      ),
    );
  }
}
