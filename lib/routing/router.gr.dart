// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:birdiefy/features/login/view/view.dart' as _i1;
import 'package:birdiefy/features/page_not_found/view/view.dart' as _i2;
import 'package:birdiefy/features/register/view/view.dart' as _i3;
import 'package:birdiefy/features/round/view/view.dart' as _i4;
import 'package:birdiefy/features/tab/view/view.dart' as _i5;
import 'package:birdiefy/features/user/view/view.dart' as _i6;
import 'package:birdiefy/features/welcome/view/view.dart' as _i7;
import 'package:birdiefy/routing/guard.dart' as _i10;
import 'package:flutter/material.dart' as _i9;

class AppRouter extends _i8.RootStackRouter {
  AppRouter({
    _i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(child: const _i1.LoginPage()),
      );
    },
    RouteNotFoundRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.PageNotFoundPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(child: const _i3.RegisterPage()),
      );
    },
    RoundRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RoundPage(),
      );
    },
    TabRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.TabPage(),
      );
    },
    UserRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.UserPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(child: const _i7.WelcomePage()),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i8.RouteConfig(
          RouteNotFoundRoute.name,
          path: 'page-not-found',
        ),
        _i8.RouteConfig(
          RegisterRoute.name,
          path: 'register',
        ),
        _i8.RouteConfig(
          RoundRoute.name,
          path: 'round',
          guards: [authGuard],
        ),
        _i8.RouteConfig(
          TabRoute.name,
          path: 'tab',
          guards: [authGuard],
        ),
        _i8.RouteConfig(
          UserRoute.name,
          path: 'user',
          guards: [authGuard],
        ),
        _i8.RouteConfig(
          WelcomeRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.PageNotFoundPage]
class RouteNotFoundRoute extends _i8.PageRouteInfo<void> {
  const RouteNotFoundRoute()
      : super(
          RouteNotFoundRoute.name,
          path: 'page-not-found',
        );

  static const String name = 'RouteNotFoundRoute';
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.RoundPage]
class RoundRoute extends _i8.PageRouteInfo<void> {
  const RoundRoute()
      : super(
          RoundRoute.name,
          path: 'round',
        );

  static const String name = 'RoundRoute';
}

/// generated route for
/// [_i5.TabPage]
class TabRoute extends _i8.PageRouteInfo<void> {
  const TabRoute()
      : super(
          TabRoute.name,
          path: 'tab',
        );

  static const String name = 'TabRoute';
}

/// generated route for
/// [_i6.UserPage]
class UserRoute extends _i8.PageRouteInfo<void> {
  const UserRoute()
      : super(
          UserRoute.name,
          path: 'user',
        );

  static const String name = 'UserRoute';
}

/// generated route for
/// [_i7.WelcomePage]
class WelcomeRoute extends _i8.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/',
        );

  static const String name = 'WelcomeRoute';
}
