import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextThemeExtension on TextTheme {
  TextStyle get h1 => GoogleFonts.montserrat(fontSize: 35);

  TextStyle get h2 => GoogleFonts.montserrat(fontSize: 25);

  TextStyle get h3 => GoogleFonts.montserrat(fontSize: 15);

  TextStyle get h1ExtraBold => h1.copyWith(fontWeight: FontWeight.w800);

  TextStyle get h1Medium => h1.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h1Regular => h1.copyWith(fontWeight: FontWeight.w400);

  TextStyle get h2ExtraBold => h2.copyWith(fontWeight: FontWeight.w800);

  TextStyle get h2Medium => h2.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h2Regular => h1.copyWith(fontWeight: FontWeight.w400);

  TextStyle get h3ExtraBold => h3.copyWith(fontWeight: FontWeight.w800);

  TextStyle get h3Medium => h3.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h3Regular => h1.copyWith(fontWeight: FontWeight.w400);

  TextStyle get regular => GoogleFonts.poppins(fontSize: 18);

  TextStyle get regularSmall => GoogleFonts.poppins(fontSize: 12);
}