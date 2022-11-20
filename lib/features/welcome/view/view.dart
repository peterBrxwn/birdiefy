// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:birdiefy/features/welcome/bloc/welcome_bloc.dart';
import 'package:birdiefy/utils/app_theme.dart';

class WelcomePage extends StatelessWidget implements AutoRouteWrapper {
  const WelcomePage({Key? key}) : super(key: key);

  static const routeName = '';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc()..add(const Init()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.loadComplete) {
          context.router.removeUntil((_) => false);
          context.router.pushNamed(state.nextRoute);
        }
      },
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50),
            Text(
              'Birdiefy',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: AppTheme.themeGreen),
            ),
            const SizedBox(height: 20),
            Text(
              'Upgrade your golf game!',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
