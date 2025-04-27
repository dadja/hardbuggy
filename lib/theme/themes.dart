import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pallet_color.dart';

final ThemeData spaceGameTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: PalletColor.backgroundColor,
  primaryColor: PalletColor.primaryColor,
  shadowColor: Colors.purpleAccent,
  colorScheme: ColorScheme.dark(
    primary: PalletColor.primaryColor,
    secondary: PalletColor.secondaryColor,
    surface: PalletColor.surfaceColor,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white70,
    onError: PalletColor.errorColor,
  ),
  // Optional: Sci-fi font if you want
  textTheme: GoogleFonts.bungeeInlineTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PalletColor.primaryColor,
      foregroundColor: Colors.white,
      shadowColor: Colors.purpleAccent,
      elevation: 10,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(PalletColor.secondaryColor),
    trackColor: WidgetStateProperty.all(
        PalletColor.secondaryColor.withValues(alpha: 0.4)),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: PalletColor.surfaceColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: PalletColor.secondaryColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    elevation: 4,
    shadowColor: Colors.purpleAccent,
  ),
);
