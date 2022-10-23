// Flutter imports:
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final ButtonColorEnum color;
  final IconData icon;
  final bool isFa5;
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const IconTextButton({
    required this.icon,
    required this.onPressed,
    required this.text,
    this.color = ButtonColorEnum.primary,
    this.isFa5 = false,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle;
    TextStyle textStyle;
    Color? iconColor;

    switch (color) {
      case ButtonColorEnum.primary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        );
        textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.white,
            );
        iconColor = AppTheme.white;
        break;
      case ButtonColorEnum.error:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).errorColor,
        );
        textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.white,
            );
        iconColor = AppTheme.white;
        break;
      default:
        buttonStyle = ElevatedButton.styleFrom(backgroundColor: AppTheme.white);
        textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).primaryColor,
            );
        iconColor = Theme.of(context).primaryColor;
    }
    return ElevatedButton.icon(
      key: widgetKey,
      icon: Icon(icon, color: iconColor, size: isFa5 ? 18 : null),
      style: buttonStyle,
      label: Text(text, style: textStyle),
      onPressed: onPressed,
    );
  }
}
