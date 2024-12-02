import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

/// Light theme
final ThemeData appTheme = ThemeData(
  dialogBackgroundColor: AppColors.lightGray,
  cardColor: AppColors.dark,
  appBarTheme: AppBarTheme(
    // shadowColor: AppColors.lightGray,
    color: AppColors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 1,
    shadowColor: AppColors.lightGray,
    toolbarTextStyle: const TextTheme(
      titleLarge: AppTextStyle.xxxLargeBlack,
    ).bodyLarge,
    titleTextStyle: const TextTheme(
      titleLarge: AppTextStyle.xxxLargeBlack,
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  fontFamily: "Georgia",
  scaffoldBackgroundColor: AppColors.white,
  iconTheme: const IconThemeData(color: AppColors.black, size: 25),
  textTheme: const TextTheme(
    headlineLarge: AppTextStyle.xxxLargeBlack,
    headlineMedium: AppTextStyle.xLargeBlack,
    titleMedium: AppTextStyle.xSmallBlack,
    titleSmall: AppTextStyle.smallBlack,
    bodyLarge: AppTextStyle.largeBlack,
    bodyMedium: AppTextStyle.mediumBlack,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    contrastLevel: 1.0,
    seedColor: AppColors.primary,
    primary: AppColors.primary,
  ).copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.sp,
      ),
      suffixIconColor: AppColors.black,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      errorMaxLines: 2),
);

/// Dark theme
final ThemeData darkAppTheme = ThemeData(
  dialogBackgroundColor: AppColors.dark,
  cardColor: AppColors.primary.withOpacity(0.5),
  appBarTheme: AppBarTheme(
    shadowColor: AppColors.lightGray,
    color: AppColors.dark,
    elevation: 1.5,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.white),
    toolbarTextStyle: const TextTheme(
      titleLarge: AppTextStyle.xxxLargeWhite,
    ).bodyLarge,
    titleTextStyle: const TextTheme(
      titleLarge: AppTextStyle.xxxLargeWhite,
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  fontFamily: "Georgia",
  scaffoldBackgroundColor: AppColors.dark,
  iconTheme: const IconThemeData(color: AppColors.white, size: 25),
  textTheme: const TextTheme(
    headlineLarge: AppTextStyle.xxxLargeWhite,
    headlineMedium: AppTextStyle.xLargeWhite,
    titleMedium: AppTextStyle.xSmallWhite,
    titleSmall: AppTextStyle.smallWhite,
    bodyLarge: AppTextStyle.largeWhite,
    bodyMedium: AppTextStyle.mediumWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 50.w,
        vertical: 12.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    contrastLevel: 1.0,
    seedColor: AppColors.primary,
    primary: AppColors.primary,
  ).copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10.w,
    ),
    filled: true,
    suffixIconColor: AppColors.white,
    fillColor: AppColors.transparent,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    errorMaxLines: 2,
  ),
);