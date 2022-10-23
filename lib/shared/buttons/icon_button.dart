// Flutter imports:
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeIconButton extends StatelessWidget {
  final ButtonColorEnum color;
  final bool hasBg;
  final IconData icon;
  final bool isFa5;
  final Function() onPressed;
  final Key? widgetKey;

  const ThemeIconButton({
    required this.icon,
    required this.onPressed,
    this.color = ButtonColorEnum.primary,
    this.hasBg = false,
    this.isFa5 = false,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor;

    switch (color) {
      case ButtonColorEnum.error:
        iconColor = Theme.of(context).errorColor;
        break;
      case ButtonColorEnum.primary:
        iconColor = Theme.of(context).primaryColor;
        break;
      default:
        iconColor = AppTheme.lightGrey;
    }

    final iconWidget = IconButton(
      key: widgetKey,
      icon: Icon(icon),
      color: hasBg ? AppTheme.white : iconColor,
      iconSize: isFa5 ? 18 : 24,
      onPressed: onPressed,
    );
    if (!hasBg) return iconWidget;
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 48.5,
      width: 48.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: iconColor,
      ),
      child: iconWidget,
    );
  }
}
