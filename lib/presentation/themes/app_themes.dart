import 'package:auto_silent_app/data/constants/theme_constants.dart';
import 'package:auto_silent_app/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class AppThemes {
  AppThemes._();

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
        fontFamily: 'Montserrat',
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: const Color(0xFF0E0F0E),
        colorScheme: AppColors.darkColorScheme());
  }

  static ThemeData lightheme(BuildContext context) {
    return ThemeData(
        fontFamily: 'Montserrat',
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        colorScheme: AppColors.lightColorScheme());
  }

  static List<AppTheme> getAppThemes(BuildContext context) {
    return [
      AppTheme(
          id: ThemeConstants.lightThemeId,
          description: ThemeConstants.lightThemeDescription,
          data: lightheme(context)),
      AppTheme(
          id: ThemeConstants.darkThemeId,
          description: ThemeConstants.darkThemeDescription,
          data: darkTheme(context))
    ];
  }
}
