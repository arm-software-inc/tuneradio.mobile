import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData defaultTheme() {
    final backgroundColor = const Color(0xAA251356).withOpacity(1);

    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      iconTheme: const IconThemeData(
        color: Colors.purpleAccent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        actionsIconTheme: const IconThemeData(
          color: Colors.purpleAccent,
        ),   
        iconTheme: const IconThemeData(
          color: Colors.purpleAccent,
        ),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.purple,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: backgroundColor,
        selectedIconTheme: const IconThemeData(
          color: Colors.purpleAccent,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}