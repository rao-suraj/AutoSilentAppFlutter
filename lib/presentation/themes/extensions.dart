import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextThemeExtension on TextTheme {
  TextStyle get h1 => GoogleFonts.montserrat(fontSize: 35);

  TextStyle get h2 => GoogleFonts.montserrat(fontSize: 25);

  TextStyle get h2low => GoogleFonts.montserrat(fontSize: 20);

  TextStyle get h3 => GoogleFonts.montserrat(fontSize: 15);

  TextStyle get h4 => GoogleFonts.montserrat(fontSize: 12);

  TextStyle get regular => GoogleFonts.poppins(fontSize: 18);

  TextStyle get regularSmall => GoogleFonts.poppins(fontSize: 12);

  TextStyle get h1ExtraBold => h1.copyWith(fontWeight: FontWeight.w800);

  TextStyle get h1Bold => h1.copyWith(fontWeight: FontWeight.w600);

  TextStyle get h1Medium => h1.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h1Regular => h1.copyWith(fontWeight: FontWeight.w400);

  TextStyle get h2ExtraBold => h2.copyWith(fontWeight: FontWeight.w800);

  TextStyle get h2Medium => h2.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h2Regular => h1.copyWith(fontWeight: FontWeight.w400);

  TextStyle get h3ExtraBold => h3.copyWith(fontWeight: FontWeight.w800);

  TextStyle get h3Bold => h3.copyWith(fontWeight: FontWeight.w600);

  TextStyle get h3Medium => h3.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h3Regular => h3.copyWith(fontWeight: FontWeight.w400);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension IntExtension on int {
  String getWeek() {
    switch (this) {
      case 0:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "could not determine";
    }
  }
}
