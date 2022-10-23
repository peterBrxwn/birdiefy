// Flutter imports:
import 'package:fiber/features/app_data/bloc/app_data_bloc.dart';
import 'package:fiber/core/domain/entity/enums.dart';
import 'package:fiber/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocBuilder<AppDataBloc, AppDataState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        switch (color) {
          case ButtonColorEnum.primary:
            bgColor = state.isDarkMode
                ? AppTheme.notBlack
                : Theme.of(context).primaryColor;
            break;
          case ButtonColorEnum.error:
            bgColor = state.isDarkMode
                ? AppTheme.notBlack
                : Theme.of(context).errorColor;
            break;
          default:
            bgColor = AppTheme.adaptiveGrey(state.isDarkMode);
        }
        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: width, height: height),
          child: ElevatedButton(
            key: widgetKey,
            child: child,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              padding: EdgeInsets.zero,
            ),
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
