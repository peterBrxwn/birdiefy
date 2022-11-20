// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:birdiefy/utils/app_theme.dart';

class AppInputDecoration extends InputDecoration {
  @override
  InputBorder get enabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.transparent),
      );

  @override
  FloatingLabelBehavior get floatingLabelBehavior =>
      FloatingLabelBehavior.never;

  @override
  InputBorder get focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppTheme.themeGreen,
        ),
      );

  @override
  TextStyle get labelStyle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppTheme.grey,
      );

  @override
  int get helperMaxLines => 3;

  @override
  bool get isDense => true;

  @override
  Color get fillColor => AppTheme.background;

  @override
  bool get filled => true;

  AppInputDecoration({
    required String labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    String? helperText,
  }) : super(
          helperText: helperText,
          labelText: labelText,
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: AppTheme.themeGreen, size: 18),
          suffixIcon: suffixIcon,
        );
}
