import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class ThemeFonts {
  static double headerFontSize = 18.0;
  static double defaultFontSize = 20.0;
  static double logReg = 58.0;

  static TextStyle textStyle600 = GoogleFonts.chewy(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w600,
      color: ThemeColor.orange);

  static TextStyle textStyle200 = GoogleFonts.roboto(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w600,
      color: ThemeColor.orange);

  static TextStyle textStyle300 = GoogleFonts.poppins(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w300,
      color: ThemeColor.primaryTextColor);

  static TextStyle textItem = GoogleFonts.poppins(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w300,
      color: ThemeColor.black);

  static TextStyle textStyle400 = GoogleFonts.balooPaaji(
    fontSize: logReg,
    fontWeight: FontWeight.w400,
    color: ThemeColor.white,
  );

  static TextStyle textStyle500 = GoogleFonts.baloo(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w500,
      color: ThemeColor.primaryTextColor);

  static TextStyle tPrice = GoogleFonts.anton(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w500,
      color: ThemeColor.primOrange,
  );
}
