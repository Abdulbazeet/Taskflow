import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppThemes {
  // AppThemes._()
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFFFFC107),
      surface: Color(0xFFF5F5F5),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: Color(0xFF212121),
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  //dark theme

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFFFFC107),
      surface: Color(0xFF121212),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: Color(0xFFFFFFFF),
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
