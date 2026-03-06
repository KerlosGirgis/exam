import 'package:exam/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData light = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ColorManager.greyColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        color: ColorManager.hintColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.greyColor),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.errorColor),
        borderRadius: BorderRadius.circular(4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.greyColor),
        borderRadius: BorderRadius.circular(4),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.errorColor),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}
