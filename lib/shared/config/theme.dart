import 'package:flutter/material.dart';

// Theme needs hot restart

ThemeData themeData = ThemeData(
  platform: TargetPlatform.iOS,
  filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)))),
  switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.orange.shade400),
      trackColor:
          MaterialStateProperty.all(Colors.grey.shade400.withOpacity(0.5)),
      overlayColor:
          MaterialStateProperty.all(Colors.orange.shade400.withOpacity(0.3))),
  outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
          side: MaterialStatePropertyAll(BorderSide(color: Colors.orange)))),
  splashColor: Colors.orange.shade100.withOpacity(0.3),
  highlightColor: Colors.orange.shade100.withOpacity(0.3),
  checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.orange.shade400),
      overlayColor: MaterialStatePropertyAll(Colors.orange.shade100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: MaterialStateBorderSide.resolveWith(
        (states) => BorderSide(width: 2.0, color: Colors.orange.shade400),
      ),
      checkColor: const MaterialStatePropertyAll(Colors.white)),
  dialogTheme: DialogTheme(
      elevation: 0,
      titleTextStyle:
          TextStyle(fontSize: FontSize.subtitle, color: Colors.grey.shade600)),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 22,
      color: Colors.grey.shade800,
    ),
  ),
  tabBarTheme: TabBarTheme(
    dividerColor: Colors.transparent,
    labelStyle: const TextStyle(fontSize: 16),
    unselectedLabelStyle: const TextStyle(fontSize: 16),
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Colors.orange.shade400,
    unselectedLabelColor: Colors.grey.shade100.withOpacity(0.8),
  ),
  timePickerTheme: const TimePickerThemeData(elevation: 0),
  scaffoldBackgroundColor: Colors.white,
  iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(28),
          overlayColor: MaterialStatePropertyAll(Colors.transparent))),
  chipTheme: const ChipThemeData(
      deleteIconColor: Colors.white,
      side: BorderSide(width: 0, color: Colors.transparent),
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)))),
  datePickerTheme:
      const DatePickerThemeData(backgroundColor: Colors.white, elevation: 0),
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      hoverColor: Colors.orange.shade400,
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange.shade400, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10))),
  useMaterial3: true,
  iconTheme: IconThemeData(color: Colors.orange.shade500),
  navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: Colors.transparent,
      indicatorColor: Colors.orange.shade400,
      backgroundColor: Colors.grey.shade900),
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
  ),
  snackBarTheme: const SnackBarThemeData(),
  appBarTheme: AppBarTheme(
      shadowColor: Colors.grey.withOpacity(.2),
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      scrolledUnderElevation: 4,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.grey.shade900,
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange, backgroundColor: Colors.white),
);

abstract class FontSize {
  static double title = 18;
  static double subtitle = 16;
  static double info = 14;
  static double infoSmall = 12;
  static double label = 10;
}
