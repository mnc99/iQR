import 'package:flutter/material.dart';

class AppThemes {
  static Color primaryColor = Colors.grey.shade900;
  static const Color accentColor = Colors.greenAccent;

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: accentColor,
      elevation: 0,
    ),

    // Textfield Theme
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: accentColor,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(30.0)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: accentColor,
          width: 2.75
        ),
        borderRadius: BorderRadius.circular(30.0)
      ),
    ),

    // Elevated Buttons theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(accentColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),

      )
    )
    
  );
} 