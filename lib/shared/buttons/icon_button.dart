// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:birdiefy/utils/app_theme.dart';

class ThemeIconButton extends StatelessWidget {
  final bool hasBg;
  final IconData icon;
  final bool isFa5;
  final Function() onPressed;
  final Key? widgetKey;

  const ThemeIconButton({
    required this.icon,
    required this.onPressed,
    this.hasBg = false,
    this.isFa5 = false,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final iconWidget = IconButton(
      key: widgetKey,
      icon: Icon(icon),
      color: hasBg ? AppTheme.white : AppTheme.lightGrey,
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
        color: AppTheme.lightGrey,
      ),
      child: iconWidget,
    );
  }
}
