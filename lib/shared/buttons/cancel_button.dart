// Flutter imports:
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const CancelButton({
    required this.onPressed,
    required this.text,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: AppTheme.grey),
      ),
    );
  }
}
