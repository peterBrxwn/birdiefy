// Flutter imports:
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final Widget child;
  final ButtonColorEnum color;
  final double? height;
  final Function() onPressed;
  final Key? widgetKey;
  final double? width;

  const WidgetButton({
    required this.child,
    required this.onPressed,
    this.color = ButtonColorEnum.primary,
    this.height = 48.5,
    this.widgetKey,
    this.width = 48.5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? bgColor;

    switch (color) {
      case ButtonColorEnum.primary:
        bgColor = Theme.of(context).primaryColor;
        break;
      case ButtonColorEnum.error:
        bgColor = Theme.of(context).errorColor;
        break;
      default:
        bgColor = AppTheme.lightGrey;
    }
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width, height: height),
      child: ElevatedButton(
        key: widgetKey,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
