// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:rounded_loading_button/rounded_loading_button.dart';

// Project imports:
import 'package:birdiefy/utils/app_theme.dart';

class LoadingButton extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const LoadingButton({
    required this.controller,
    required this.onPressed,
    required this.text,
    this.widgetKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      key: widgetKey,
      borderRadius: 50,
      controller: controller,
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      width: 200,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: AppTheme.black),
        ),
      ),
    );
  }
}
