import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFF282C34),
  scaffoldBackgroundColor: const Color(0xFF181A21),
  cardColor: Color(0xFF1E222A),
  textTheme: TextTheme(
    titleMedium: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.grey[300]!,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.grey[300]!,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181A21),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: const Color(0xFF181A21),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF181A21),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xffffffff),
    size: 20,
  ),
  brightness: Brightness.dark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181A21),
    elevation: 0,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey[100]!,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
    ),
    labelStyle: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color(0xffffffff),
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey[200]!,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color(0xffffffff),
        )),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF181A21),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: const Color(0xffffffff),
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[400]!,
    thickness: 1,
  ),
);

final lightTheme = ThemeData(
  primaryColor: const Color(0xfffffffff),
  secondaryHeaderColor: Colors.grey[100],
  scaffoldBackgroundColor: const Color(0xffffffff),
  textTheme: TextTheme(
    titleMedium: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF181A21),
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF181A21),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF181A21),
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF181A21),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF181A21),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff000000),
    size: 20,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: const Color(0xFF474849),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: const Color(0xFF474849),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: const Color(0xFF474849),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color(0xFF474849), width: 1),
    ),
    labelStyle: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color(0xff000000),
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color(0xff666666),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color(0xffffffff),
        )),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: const Color(0xff000000),
      ),
    ),
  ),
);
