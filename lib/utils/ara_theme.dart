// import 'package:flutter/material.dart';

import 'package:floaty_bird/utils/extension.dart';
import 'package:flutter/material.dart';

class Styles {
  static const Color araDarkLogoColor = Color(0xff202124);
  // static const Color darkBrown = Color(0xffC25507);
  static const Color darkBrown = Color(0xffA05D20);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff000000);
  static const Color redColor = Color(0xffE45757);
  static const Color pinkColor = Color(0xffEE4274);
  static const Color lightPurpleColor = Color(0xffCBC8FF);
  static const Color purpleColor = Color(0xff5C38DF);
  static const Color darkBlueColor = Color(0xff1101F4);
  static const Color lightBlueColor = Color(0xff5383EC);
  static const Color lightYellowColor = Color(0xffF5C95F);
  static const Color darkRedColor = Color(0xffB31E1B);
  static const Color redErrorColor = Color(0xffFF1D1D);
  static const Color lightCreamColor = Color(0xffFBC0A6);
  static const Color darkCreamColor = Color(0xff843614);
  static const Color greenColor = Color(0xff5CB75E);
  static const Color lightIndigoColor = Color(0xff5383EC);
  static const Color graphBarColor = Color(0xffDADEE1);
  static const Color darkGreenColor = Color(0xff1D7529);
  static const Color lightSkyColor = Color(0xff71C9DA);
  static const Color lightGreenColor = Color(0xffE3F3E4);
  static const Color primaryGreenColor = Color(0xff5CB75E);
  static const Color disableButtonColor = Color(0xffF3F5F8);
  static const Color termsAndConditionRedColor = Color(0xffE45757);
  static const Color lightGreyTextColor = Color(0xff808080);
  static const Color disableFieldColor = Color(0xffF3F5F8);
  static const Color darkGreyColor = Color(0xff202123);
  static const Color darkTextGreyColor = Color(0xff212224);
  static const Color hintGrayColor = Color(0xffB0B0B0);
  static const Color lightThemeAccentColor = Color(0xff2CC265);
  static const Color lightThemeGreyBorderColor = Color(0xffe0e0e0);

  static const Color circleLightGreen = Color(0xffA6FBBE);
  static const Color circleLightPink = Color(0xffFBA6C1);
  static const Color circleDarkPink = Color(0xff8D133A);
  static const Color circleLightPurple = Color(0xffCCA6FB);
  static const Color grayShadeDark = Color(0xff666666);
  static const Color stepperGrayColor = Color(0xffE4E4E4);

  // static Color lightThemeGreyTextColor = const Color(0x99000000);
  static const Color lightThemeLightGreyTextColor = Color(0xff939394);
  static const Color lightThemeTextFieldColor = Color(0xffF3F5F8);

  // static const Color lightThemeScaffoldColor = Color(0xffE3F3E4);
  static const Color lightThemeScaffoldColor = Color(0xff202123);

  // static const Color lightThemePrimaryColor = Color(0xff202123);
  // static const Color lightThemePrimaryColor = Color(0xff141414);
  static const Color lightThemePrimaryColor = Color(0xff272829);
  static const Color lightThemeSecondaryColor = Color(0xffFFFFFF);

  // static const Color lightThemeTertairyColor = Color(0xff272829);
  static const Color lightThemeTertairyColor = Color(0xffF3F5F8);

  static const Color darkThemeLightGreyTextColor = Color(0xff939394);
  static const Color darkThemeTextFieldColor = Color(0xff1E1C1E);

  static const Color darkThemeGreyColor = Color(0xff202123);
  static const Color darkThemeScaffoldColor = Color(0xff141414);

  // static const Color darkThemePrimaryColor = Color(0xff272829);
  static const Color darkThemePrimaryColor = Color(0xff212121);

  // static const Color darkThemeSecondaryColor = Color(0xff272829);
  static const Color darkThemeSecondaryColor = Color(0xff292929);
  // static const Color darkThemeSecondaryColor = Color(0xff343434);
  static const Color darkThemeTertairyColor = Color(0xff343434);

// static bool lightTheme = false;

// static Color get color => lightTheme ? Colors.white : Colors.black;
}

class FloatyBirdTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Styles.lightThemePrimaryColor,
        contentTextStyle:
            TextStyle(fontFamily: "Sofia", color: Styles.blackColor)),
    appBarTheme: AppBarTheme(
      backgroundColor: Styles.lightThemePrimaryColor,
      titleTextStyle: TextStyle(
        fontSize: 24.0.sp,
        color: Styles.blackColor,
        fontFamily: "Sofia",
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Styles.blackColor),
      actionsIconTheme: const IconThemeData(color: Styles.blackColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Styles.lightThemePrimaryColor,
      fillColor: Styles.lightThemeTextFieldColor,
      iconColor: Styles.blackColor,
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Styles.lightThemeSecondaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Styles.lightThemeSecondaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 22.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      labelMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      labelSmall: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      titleLarge: TextStyle(
        fontSize: 22.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      titleMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Styles.blackColor,
        fontFamily: "Sofia",
      ),
      titleSmall: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.blackColor,
        fontFamily: "Sofia",
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      bodySmall: TextStyle(
          fontSize: 12.0.sp,
          color: Styles.blackColor,
          fontFamily: "Sofia",
          fontWeight: FontWeight.normal),
    ),
    dividerColor: Styles.lightThemeLightGreyTextColor,
    // popupMenuTheme: PopupMenuThemeData(color: Styles.primaryGreenColor),
    // iconTheme: const IconThemeData(color: Styles.blackColor),
    scaffoldBackgroundColor: Styles.lightThemeScaffoldColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: Styles.lightThemePrimaryColor,
        tertiary: Styles.lightThemeTertairyColor,
        // onTertiaryContainer:
        //     Styles.lightIconBackgroundContainer.withOpacity(0.5),
        secondary: Styles.lightThemeSecondaryColor),
    // add more theme attributes here
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Styles.darkThemePrimaryColor,
        contentTextStyle: TextStyle(color: Styles.whiteColor)),
    appBarTheme: AppBarTheme(
      backgroundColor: Styles.darkThemePrimaryColor,
      titleTextStyle: TextStyle(
        fontFamily: "Sofia",
        fontSize: 22.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Styles.whiteColor),
      actionsIconTheme: const IconThemeData(color: Styles.whiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Styles.darkThemeTextFieldColor,
      iconColor: Styles.whiteColor,
      suffixIconColor: Styles.whiteColor,
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.whiteColor,
        fontFamily: "Sofia",
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Styles.greenColor),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Styles.greenColor),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 22.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      labelMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      labelSmall: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      titleLarge: TextStyle(
        fontSize: 22.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      titleMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Styles.whiteColor,
        fontFamily: "Sofia",
      ),
      titleSmall: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.whiteColor,
        fontFamily: "Sofia",
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0.sp,
        color: Styles.whiteColor,
        fontWeight: FontWeight.normal,
        fontFamily: "Sofia",
      ),
      bodySmall: TextStyle(
        fontSize: 12.0.sp,
        color: Styles.whiteColor,
        fontFamily: "Sofia",
        fontWeight: FontWeight.normal,
      ),
    ),
    dividerColor: Styles.darkThemeLightGreyTextColor,

    // iconTheme: IconThemeData(color: Styles.defaultWhiteColor),
    scaffoldBackgroundColor: Styles.darkThemeScaffoldColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: Styles.darkThemePrimaryColor,
        tertiary: Styles.darkThemeTertairyColor,
        // onTertiaryContainer:
        //     Styles.darkIconBackgroundContainer.withOpacity(0.5),
        secondary: Styles.darkThemeSecondaryColor),
    // add more theme attributes here
  );
}
