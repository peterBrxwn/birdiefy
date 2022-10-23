// Flutter imports:
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:rounded_loading_button/rounded_loading_button.dart';

class DeleteButton extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const DeleteButton({
    required this.controller,
    required this.onPressed,
    this.text = 'DELETE',
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      key: widgetKey,
      borderRadius: 5,
      color: Theme.of(context).errorColor,
      width: 65,
      height: 37,
      controller: controller,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: AppTheme.white),
      ),
    );
  }
}
