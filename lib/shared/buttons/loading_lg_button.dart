// Flutter imports:
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoadingLgButton extends StatelessWidget {
  final ButtonColorEnum color;
  final RoundedLoadingButtonController controller;
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const LoadingLgButton({
    required this.controller,
    required this.onPressed,
    required this.text,
    this.color = ButtonColorEnum.primary,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color btnColor;

    switch (color) {
      case ButtonColorEnum.primary:
        btnColor = Theme.of(context).primaryColor;
        break;
      case ButtonColorEnum.error:
        btnColor = Theme.of(context).errorColor;
        break;
      default:
        btnColor = AppTheme.lightGrey;
    }
    return RoundedLoadingButton(
      key: widgetKey,
      borderRadius: 50,
      controller: controller,
      color: btnColor,
      onPressed: onPressed,
      width: 200,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppTheme.black),
        ),
      ),
    );
  }
}
