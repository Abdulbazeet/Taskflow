import 'package:flutter/material.dart';
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
      bodyLarge: TextStyle(
        color: Color(0xFF212121),
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 16.sp),
      titleSmall: TextStyle(fontSize: 14.sp),
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
      bodyLarge: TextStyle(
        color: Color(0xFF212121),
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 16.sp),
      titleSmall: TextStyle(fontSize: 14.sp),
    ),
  );
}
