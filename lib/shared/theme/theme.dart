import 'package:google_fonts/google_fonts.dart';
import 'package:ksu_budidaya/shared/theme/theme_config.dart';
import 'package:flutter/material.dart';

ThemeData getDefaultTheme() {
  return ThemeData(
    useMaterial3: false,
  ).copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xffEFF2F3),
    colorScheme: const ColorScheme.light(
      primary: yellow500,
      onPrimary: gray900,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appbarBackgroundColor,
      elevation: 0,
      titleTextStyle: myTextTheme.titleMedium?.copyWith(color: gray900),
      iconTheme: const IconThemeData(
        color: gray900,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blueGrey[900]!,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.blueGrey[900]!,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: gray900,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: gray900,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: gray900,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: gray900,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: gray900,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: gray900,
      ),
      labelSmall: GoogleFonts.lato(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: gray900,
      ),
    ),
  );
}
