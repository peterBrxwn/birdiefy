import 'package:flutter/material.dart';

class FiberInputDecoration extends InputDecoration {
  @override
  InputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(),
      );

  @override
  TextStyle get labelStyle => const TextStyle(fontWeight: FontWeight.normal);

  @override
  int get helperMaxLines => 3;

  @override
  bool get isDense => true;

  const FiberInputDecoration({
    required String labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? helperText,
  }) : super(
          helperText: helperText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
    // return InputDecoration(
    //   // fillColor: AppTheme.adaptiveGrey(context),
    //   // filled: true,
    //   helperText: helperText,
    //   suffixIcon: suffixIcon,
    //   prefixIcon: prefixIcon,
    //   labelText: labelText,
    //   // enabledBorder: OutlineInputBorder(
    //   //   borderSide: BorderSide(color: AppTheme.adaptiveGrey(context)),
    //   // ),
    // );
}
