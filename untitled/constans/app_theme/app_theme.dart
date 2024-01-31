import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/app_config/app_font_family.dart';
import 'package:haatinhandseller/constans/app_config/app_font_size_constants.dart.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      splashColor: Colors.green.withOpacity(0.2),
      highlightColor: Colors.green.withOpacity(0.1),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorConstant.primaryColor,
        primary: AppColorConstant.primaryColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      fontFamily: 'PoppinsRegular',
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: poppinsSemiBold,
          fontSize: AppFontSizeConstant.fontSize16,
        ),
        centerTitle: true,
        backgroundColor: AppColorConstant.grayDark,
        toolbarHeight: 60.0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorConstant.whiteColor,
        unselectedItemColor: AppColorConstant.greyColor,
        selectedItemColor: AppColorConstant.primaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          backgroundColor: AppColorConstant.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          textStyle: TextStyle(
            fontFamily: poppinsRegular,
            fontSize: AppFontSizeConstant.fontSize16,
            color: Colors.white,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.green.withOpacity(0.2),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.green.withOpacity(0.2),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          // backgroundColor:
          //     MaterialStateProperty.all<Color>(AppColorConstant.secondaryColor),
          elevation: MaterialStateProperty.all<double>(0),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: AppColorConstant.primaryColor),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(color: AppColorConstant.primaryColor),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontFamily: poppinsRegular,
              fontSize: AppFontSizeConstant.fontSize14,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorConstant.primaryColor,
        elevation: 3.0,
        shape: CircleBorder(),
      ),
      // textTheme: TextTheme(
      //   headline1: TextStyle(
      //       fontSize: 32.0,
      //       fontWeight: FontWeight.w700,
      //       color: AppColorConstant.fontColor1),
      //   headline2: TextStyle(
      //       fontSize: AppFontSizeConstant.fontSize24,
      //       fontWeight: FontWeight.w500,
      //       color: AppColorConstant.fontColor1,
      //       height: 1.5),
      //   headline3: TextStyle(
      //       fontSize: 22.0,
      //       fontWeight: FontWeight.w500,
      //       color: AppColorConstant.fontColor1),
      //   headline4: TextStyle(
      //       fontSize: AppFontSizeConstant.fontSize18,
      //       fontWeight: FontWeight.w500,
      //       color: AppColorConstant.fontColor1),
      //   bodyText1: TextStyle(
      //     fontSize: AppFontSizeConstant.fontSize14 - 2.0,
      //     color: Colors.black,
      //   ),
      //   bodyText2: TextStyle(
      //     fontSize: AppFontSizeConstant.fontSize14,
      //     color: AppColorConstant.primaryColor,
      //   ),
      //   button: TextStyle(
      //     color: AppColorConstant.fontColor1,
      //   ),
      // ),
    );
  }
}
