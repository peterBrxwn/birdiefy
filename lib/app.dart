import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/injection.dart';
import 'package:birdiefy/routing/router.gr.dart';
import 'package:birdiefy/routing/observer.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class Birdiefy extends StatelessWidget {
  Birdiefy({Key? key}) : super(key: key);
  final _appRouter = locator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AppRouteObserver()],
      ),
      theme: AppTheme.themeDataLight,
      darkTheme: AppTheme.themeDataDark,
      debugShowCheckedModeBanner: false,
    );
  }
}
