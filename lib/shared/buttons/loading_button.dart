// Flutter imports:
import 'package:fiber/features/app_data/bloc/app_data_bloc.dart';
import 'package:fiber/core/domain/entity/entity.dart';
import 'package:fiber/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoadingButton extends StatelessWidget {
  final ButtonColorEnum color;
  final RoundedLoadingButtonController controller;
  final Function() onPressed;
  final String text;
  final Key? widgetKey;

  const LoadingButton({
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
    return BlocBuilder<AppDataBloc, AppDataState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        switch (color) {
          case ButtonColorEnum.primary:
            btnColor = Theme.of(context).primaryColor;
            break;
          case ButtonColorEnum.error:
            btnColor = Theme.of(context).errorColor;
            break;
          default:
            btnColor = AppTheme.adaptiveGrey(state.isDarkMode);
        }

        return RoundedLoadingButton(
          key: widgetKey,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: AppTheme.white),
          ),
          borderRadius: 5,
          controller: controller,
          color: btnColor,
          onPressed: onPressed,
          width: 65,
          height: 37,
        );
      },
    );
  }
}
