import 'package:flutter/material.dart';

class AppColor {
  // static const primary = Color(0xFF0C55C3);
  // static const primaryText = Color(0xFF001F3F);
  // static const primaryBtn = Color(0xFF0C55C3);
  static const primary = Color(0xFFF21A3E);
  static const secondPrime = Color(0xFFFF0000);
  static const primaryText = Color(0xFF000000);
  static const primaryBtn = Color(0xFFF21A3E);

  // static const secondary = Color(0xFF0C55C3);
  static const secondary = Color(0xFFF21A3E);
  static const secondaryText = Color(0xFF000000);

  static const backgroundColor = Color(0xFFF5F5F5);
  static const divider = Color(0xFFE4E5E6);

  static const white = Color(0xFFFFFFFF);
  static const green = Color(0xFFBB0120);
  static const lightPink = Color(0xFFfffbff);
  static const transparent = Color(0x00000000);
  static const grey = Color(0xFF9E9E9E);
  static const lightGrey = Color(0xFFD3D3D3);
  static const darkGrey = Color(0xFF7B808C);
  static const black = Color(0xFF000000);
  static const blue = Color(0xFF2196F3);
  static const red = Color(0xFF8B0000);
  static const yellow = Color(0xFFFFEB3B);
  static const hardOrange = Color(0xFFF23639);
  static const pinkRed = Color(0xFFF21A3E);
  static const lightred = Color(0xFFFFCDCE);
  static const softPink = Color(0xFFFFDDE3);
  static const highlightCyan = Color(0xFFE0F7FA);
  static const grey300 = Color(0xFFE0E0E0);
  static const grey400 = Color(0xFFBDBDBD);
  static const grey600 = Color(0xFF757575);
}

/// Naming Conventions:
/// Font size
/// - extra huge: 26
/// - huge: 24
/// - large: 20
/// - medium: 18
/// - mid: 16
/// - normal: 14
/// - small: 12
/// Font weight
/// - regular: w400
/// - medium: w500
/// - semiBold: w600
/// - bold: w700
/// Format: {fontsize}{color}{weight}
class AppTextStyle {
  // fontSize: 26
  static const extraHugeBlackSemiBold = TextStyle(
    color: AppColor.black,
    fontSize: 26,
    fontWeight: AppStyle._semiBold,
  );

  // fontSize: 24
  static const hugeWhiteBold = TextStyle(
    color: AppColor.white,
    fontSize: 24,
    fontWeight: AppStyle._bold,
  );
  static const hugePrimarySemiBold = TextStyle(
    color: AppColor.primary,
    fontSize: 24,
    fontWeight: AppStyle._semiBold,
  );

  // fontSize: 20
  static const largePrimaryBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 20,
    fontWeight: AppStyle._bold,
  );
  static const largeWhiteMedium = TextStyle(
    color: AppColor.white,
    fontSize: 20,
    fontWeight: AppStyle._medium,
  );

  static const largeWhiteBold = TextStyle(
    color: AppColor.white,
    fontSize: 20,
    fontWeight: AppStyle._medium,
  );

  static const largePrimaryRegular = TextStyle(
    color: AppColor.primaryText,
    fontSize: 20,
    fontWeight: AppStyle._regular,
  );

  // fontSize: 18
  static const mediumPrimarySemiBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 18,
    fontWeight: AppStyle._semiBold,
  );
  static const mediumPrimartSemiBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 18,
    fontWeight: AppStyle._semiBold,
  );
  static const mediumRedSemiBold = TextStyle(
    color: AppColor.red,
    fontSize: 18,
    fontWeight: AppStyle._semiBold,
  );
  static const mediumPrimaryBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 18,
    fontWeight: AppStyle._bold,
  );
  static const mediumRedBold = TextStyle(
    color: AppColor.red,
    fontSize: 18,
    fontWeight: AppStyle._bold,
  );
  static const mediumWhiteSemiBold = TextStyle(
    color: AppColor.white,
    fontSize: 18,
    fontWeight: AppStyle._semiBold,
  );
  static const mediumWhiteMedium = TextStyle(
    color: AppColor.white,
    fontSize: 18,
    fontWeight: AppStyle._medium,
  );

  // fontSize: 16
  static const midWhiteSemiBold = TextStyle(
    color: AppColor.white,
    fontSize: 16,
    fontWeight: AppStyle._semiBold,
  );
  static const midSecondaryBold = TextStyle(
    color: AppColor.secondary,
    fontSize: 16,
    fontWeight: AppStyle._bold,
  );
  static const midPrimaryBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 16,
    fontWeight: AppStyle._bold,
  );
  static const midPrimarySemiBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 16,
    fontWeight: AppStyle._semiBold,
  );
  static const midPrimaryRegular = TextStyle(
    color: AppColor.primaryText,
    fontSize: 16,
    fontWeight: AppStyle._regular,
  );
  static const midRedRegular = TextStyle(
    color: AppColor.red,
    fontSize: 16,
    fontWeight: AppStyle._regular,
  );
  static const midRedBold = TextStyle(
    color: AppColor.red,
    fontSize: 16,
    fontWeight: AppStyle._bold,
  );
  static const midWhiteRegular = TextStyle(
    color: AppColor.white,
    fontSize: 16,
    fontWeight: AppStyle._regular,
  );

  // fontSize: 14
  static const normalPrimaryBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 14,
    fontWeight: AppStyle._bold,
  );
  static const normalWhiteBold = TextStyle(
    color: AppColor.white,
    fontSize: 14,
    fontWeight: AppStyle._bold,
  );
  static const normalRedSemiBold = TextStyle(
    color: AppColor.red,
    fontSize: 14,
    fontWeight: AppStyle._semiBold,
  );
  static const normalRedBold = TextStyle(
    color: AppColor.red,
    fontSize: 14,
    fontWeight: AppStyle._bold,
  );
  static const normalPrimarySemiBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 14,
    fontWeight: AppStyle._semiBold,
  );
  static const normalSecondaryBold = TextStyle(
    color: AppColor.secondary,
    fontSize: 14,
    fontWeight: AppStyle._bold,
  );
  static const normalBlueBold = TextStyle(
    color: AppColor.blue,
    fontSize: 14,
    fontWeight: AppStyle._bold,
  );
  static const normalPrimaryRegular = TextStyle(
    color: AppColor.primaryText,
    fontSize: 14,
    fontWeight: AppStyle._regular,
  );
  static const normalWhiteRegular = TextStyle(
    color: AppColor.white,
    fontSize: 14,
    fontWeight: AppStyle._regular,
  );
  static const normalRedRegular = TextStyle(
    color: AppColor.red,
    fontSize: 14,
    fontWeight: AppStyle._regular,
  );
  static const normalSecondaryRegular = TextStyle(
    color: AppColor.secondaryText,
    fontSize: 14,
    fontWeight: AppStyle._regular,
  );
  static const normalGreyRegular = TextStyle(
    color: AppColor.grey,
    fontSize: 14,
    fontWeight: AppStyle._regular,
  );
  static const normalLightGreyRegular = TextStyle(
    color: AppColor.lightGrey,
    fontSize: 14,
    fontWeight: AppStyle._regular,
  );

  // fontSize: 12
  static const smallPrimaryRegular = TextStyle(
    color: AppColor.primaryText,
    fontSize: 12,
    fontWeight: AppStyle._regular,
  );
  static const smallWhiteSemibold = TextStyle(
    color: AppColor.white,
    fontSize: 12,
    fontWeight: AppStyle._semiBold,
  );
  static const smallGreenSemiBold = TextStyle(
    color: AppColor.green,
    fontSize: 12,
    fontWeight: AppStyle._semiBold,
  );
  static const smallYellowSemibold = TextStyle(
    color: AppColor.yellow,
    fontSize: 12,
    fontWeight: AppStyle._regular,
  );
  static const smallBlueSemibold = TextStyle(
    color: AppColor.blue,
    fontSize: 12,
    fontWeight: AppStyle._regular,
  );
  static const smallRedSemibold = TextStyle(
    color: AppColor.red,
    fontSize: 12,
    fontWeight: AppStyle._semiBold,
  );
  static const smallRedRegular = TextStyle(
    color: AppColor.red,
    fontSize: 12,
    fontWeight: AppStyle._regular,
  );
  static const smallGreyRegular = TextStyle(
    color: AppColor.grey,
    fontSize: 12,
    fontWeight: AppStyle._regular,
  );
  static const smallGreySemiBold = TextStyle(
    color: AppColor.grey,
    fontSize: 12,
    fontWeight: AppStyle._semiBold,
  );
  static const smallPrimarySemibold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 12,
    fontWeight: AppStyle._semiBold,
  );
  static const smallPrimaryBold = TextStyle(
    color: AppColor.primaryText,
    fontSize: 12,
    fontWeight: AppStyle._bold,
  );
}

class AppStyle {
  AppStyle._();

  static ThemeData themeData() {
    return ThemeData(
      primaryColor: AppColor.primary,
      unselectedWidgetColor: const Color(0xFFDFE4E9),
      scaffoldBackgroundColor: AppColor.white,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0.5,
        titleTextStyle: AppTextStyle.mediumWhiteMedium,
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      // tabBarTheme: const TabBarTheme(
      //   unselectedLabelColor: AppColor.black,
      //   indicator: UnderlineTabIndicator(
      //     borderSide: BorderSide(color: AppColor.black),
      //   ),
      // ),
      textTheme: _textTheme,
      canvasColor: AppColor.transparent,
      splashColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: _regular,
      fontSize: 96.0,
      color: AppColor.primaryText,
    ),
    displayMedium: TextStyle(
      fontWeight: _regular,
      fontSize: 60.0,
      color: AppColor.primaryText,
    ),
    displaySmall: TextStyle(
      fontWeight: _regular,
      fontSize: 48.0,
      color: AppColor.primaryText,
    ),
    headlineMedium: TextStyle(
      fontWeight: _regular,
      fontSize: 34.0,
      color: AppColor.primaryText,
    ),
    headlineSmall: TextStyle(
      fontWeight: _regular,
      fontSize: 24.0,
      color: AppColor.primaryText,
    ),
    titleLarge: TextStyle(
      fontWeight: _medium,
      fontSize: 18.0,
      color: AppColor.primaryText,
    ),
    titleMedium: TextStyle(
      fontWeight: _regular,
      fontSize: 16.0,
      color: AppColor.primaryText,
    ),
    titleSmall: TextStyle(
      fontWeight: _medium,
      fontSize: 14.0,
      color: AppColor.primaryText,
    ),
    bodyLarge: TextStyle(
      fontWeight: _regular,
      fontSize: 14.0,
      color: AppColor.primaryText,
    ),
    bodyMedium: TextStyle(
      fontWeight: _regular,
      fontSize: 12.0,
      color: AppColor.primaryText,
    ),
    labelLarge: TextStyle(
      fontWeight: _semiBold,
      fontSize: 14.0,
      color: AppColor.primaryText,
    ),
    bodySmall: TextStyle(
      fontWeight: _regular,
      fontSize: 16.0,
      color: AppColor.primaryText,
    ),
    labelSmall: TextStyle(
      fontWeight: _regular,
      fontSize: 10.0,
      color: AppColor.primaryText,
    ),
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
}
