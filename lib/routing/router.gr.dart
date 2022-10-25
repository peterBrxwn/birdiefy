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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:birdiefy/features/add_round/view/view.dart' as _i1;
import 'package:birdiefy/features/login/view/view.dart' as _i2;
import 'package:birdiefy/features/page_not_found/view/view.dart' as _i3;
import 'package:birdiefy/features/register/view/view.dart' as _i4;
import 'package:birdiefy/features/round/view/view.dart' as _i7;
import 'package:birdiefy/features/tab/view/view.dart' as _i5;
import 'package:birdiefy/features/user/view/view.dart' as _i8;
import 'package:birdiefy/features/welcome/view/view.dart' as _i6;
import 'package:birdiefy/routing/guard.dart' as _i11;
import 'package:flutter/material.dart' as _i10;

class AppRouter extends _i9.RootStackRouter {
  AppRouter({
    _i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i11.AuthGuard authGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AddRoundRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i1.AddRoundPage()),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i2.LoginPage()),
      );
    },
    RouteNotFoundRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.PageNotFoundPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i4.RegisterPage()),
      );
    },
    TabRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.TabPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i6.WelcomePage()),
      );
    },
    RoundRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i7.RoundPage()),
      );
    },
    UserRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.UserPage(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          AddRoundRoute.name,
          path: 'add_round',
          guards: [authGuard],
        ),
        _i9.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i9.RouteConfig(
          RouteNotFoundRoute.name,
          path: 'page-not-found',
        ),
        _i9.RouteConfig(
          RegisterRoute.name,
          path: 'register',
        ),
        _i9.RouteConfig(
          TabRoute.name,
          path: 'tab',
          guards: [authGuard],
          children: [
            _i9.RouteConfig(
              RoundRoute.name,
              path: 'round',
              parent: TabRoute.name,
              guards: [authGuard],
            ),
            _i9.RouteConfig(
              UserRoute.name,
              path: 'user',
              parent: TabRoute.name,
              guards: [authGuard],
            ),
          ],
        ),
        _i9.RouteConfig(
          WelcomeRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.AddRoundPage]
class AddRoundRoute extends _i9.PageRouteInfo<void> {
  const AddRoundRoute()
      : super(
          AddRoundRoute.name,
          path: 'add_round',
        );

  static const String name = 'AddRoundRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.PageNotFoundPage]
class RouteNotFoundRoute extends _i9.PageRouteInfo<void> {
  const RouteNotFoundRoute()
      : super(
          RouteNotFoundRoute.name,
          path: 'page-not-found',
        );

  static const String name = 'RouteNotFoundRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.TabPage]
class TabRoute extends _i9.PageRouteInfo<void> {
  const TabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TabRoute.name,
          path: 'tab',
          initialChildren: children,
        );

  static const String name = 'TabRoute';
}

/// generated route for
/// [_i6.WelcomePage]
class WelcomeRoute extends _i9.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i7.RoundPage]
class RoundRoute extends _i9.PageRouteInfo<void> {
  const RoundRoute()
      : super(
          RoundRoute.name,
          path: 'round',
        );

  static const String name = 'RoundRoute';
}

/// generated route for
/// [_i8.UserPage]
class UserRoute extends _i9.PageRouteInfo<void> {
  const UserRoute()
      : super(
          UserRoute.name,
          path: 'user',
        );

  static const String name = 'UserRoute';
}
