// Flutter imports:
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoadingIconButton extends StatelessWidget {
  final ButtonColorEnum color;
  final RoundedLoadingButtonController controller;
  final double elevation;
  final double height;
  final IconData icon;
  final Function() onPressed;
  final Key? widgetKey;
  final double width;

  const LoadingIconButton({
    required this.controller,
    required this.icon,
    required this.onPressed,
    this.color = ButtonColorEnum.transparent,
    this.elevation = 0,
    this.height = 48.5,
    this.widgetKey,
    this.width = 48.5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color btnColor;
    Color iconColor = AppTheme.white;

    switch (color) {
      case ButtonColorEnum.primary:
        btnColor = Theme.of(context).primaryColor;
        break;
      case ButtonColorEnum.error:
        btnColor = Theme.of(context).errorColor;
        break;
      case ButtonColorEnum.transparent:
        btnColor = AppTheme.transparent;
        iconColor = Theme.of(context).primaryColor;
        break;
      case ButtonColorEnum.grey:
        btnColor = AppTheme.grey;
        break;
      default:
        btnColor = AppTheme.lightGrey;
        iconColor = Theme.of(context).primaryColor;
    }

    return RoundedLoadingButton(
      key: widgetKey,
      elevation: elevation,
      controller: controller,
      color: btnColor,
      valueColor: iconColor,
      onPressed: onPressed,
      width: width,
      height: height,
      child: Icon(icon, color: iconColor),
    );
  }
}
