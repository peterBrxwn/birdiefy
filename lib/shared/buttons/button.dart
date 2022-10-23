// Flutter imports:
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final ButtonColorEnum color;
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const Button({
    required this.onPressed,
    required this.text,
    this.color = ButtonColorEnum.primary,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle;
    TextStyle textStyle;

    switch (color) {
      case ButtonColorEnum.primary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        );
        textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.white,
            );
        break;
      case ButtonColorEnum.error:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).errorColor,
        );
        textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.white,
            );
        break;
      default:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: AppTheme.lightGrey,
        );
        textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).primaryColor,
            );
    }
    return ElevatedButton(
      key: widgetKey,
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(text, style: textStyle),
    );
  }
}
