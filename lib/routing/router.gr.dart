// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i27;
import 'package:fiber/features/404/view.dart' as _i21;
import 'package:fiber/features/add_category/view/view.dart' as _i1;
import 'package:fiber/features/add_client/view/view.dart' as _i2;
import 'package:fiber/features/add_inventory/view/view.dart' as _i3;
import 'package:fiber/features/add_loss/view/view.dart' as _i4;
import 'package:fiber/features/add_restock/view/view.dart' as _i5;
import 'package:fiber/features/add_sale/view/view.dart' as _i6;
import 'package:fiber/features/dashboard/view/view.dart' as _i22;
import 'package:fiber/features/edit_inventory/view/view.dart' as _i7;
import 'package:fiber/features/edit_loss/view/view.dart' as _i8;
import 'package:fiber/features/edit_restock/view/view.dart' as _i9;
import 'package:fiber/features/edit_sale/view/view.dart' as _i10;
import 'package:fiber/features/inventory/view/view.dart' as _i23;
import 'package:fiber/features/login/view/view.dart' as _i11;
import 'package:fiber/features/more/view/view.dart' as _i24;
import 'package:fiber/features/people/view/view.dart' as _i25;
import 'package:fiber/features/register/view/view.dart' as _i12;
import 'package:fiber/features/sales/view/view.dart' as _i26;
import 'package:fiber/features/sales_staff/view/view.dart' as _i13;
import 'package:fiber/features/setup/view/view.dart' as _i14;
import 'package:fiber/features/tab/view/view.dart' as _i15;
import 'package:fiber/features/view_inventory/view/view.dart' as _i16;
import 'package:fiber/features/view_loss/view/view.dart' as _i17;
import 'package:fiber/features/view_restock/view/view.dart' as _i18;
import 'package:fiber/features/view_sale/view/view.dart' as _i19;
import 'package:fiber/features/welcome/view/view.dart' as _i20;
import 'package:flutter/material.dart' as _i28;

class AppRouter extends _i27.RootStackRouter {
  AppRouter([_i28.GlobalKey<_i28.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    AddCategoryRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i1.AddCategoryPage()));
    },
    AddClientRoute.name: (routeData) {
      final args = routeData.argsAs<AddClientRouteArgs>(
          orElse: () => const AddClientRouteArgs());
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: _i2.AddClientPage(key: args.key)));
    },
    AddInventoryRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i3.AddInventoryPage()));
    },
    AddLossRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i4.AddLossPage()));
    },
    AddRestockRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i5.AddRestockPage()));
    },
    AddSaleRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i6.AddSalePage()));
    },
    EditInventoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditInventoryRouteArgs>(
          orElse: () => EditInventoryRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i7.EditInventoryPage(id: args.id, key: args.key)));
    },
    EditLossRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditLossRouteArgs>(
          orElse: () => EditLossRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i8.EditLossPage(id: args.id, key: args.key)));
    },
    EditRestockRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditRestockRouteArgs>(
          orElse: () => EditRestockRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i9.EditRestockPage(id: args.id, key: args.key)));
    },
    EditSaleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditSaleRouteArgs>(
          orElse: () => EditSaleRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i10.EditSalePage(id: args.id, key: args.key)));
    },
    LoginRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i11.LoginPage()));
    },
    RegisterRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => RegisterRouteArgs(
              referralId: pathParams.optString('referralId')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i12.RegisterPage(
                  referralId: args.referralId, key: args.key)));
    },
    SalesStaffRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i13.SalesStaffPage()));
    },
    SetupRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i14.SetupPage()));
    },
    TabRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i15.TabPage()));
    },
    ViewInventoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewInventoryRouteArgs>(
          orElse: () => ViewInventoryRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i16.ViewInventoryPage(id: args.id, key: args.key)));
    },
    ViewLossRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewLossRouteArgs>(
          orElse: () => ViewLossRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i17.ViewLossPage(id: args.id, key: args.key)));
    },
    ViewRestockRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewRestockRouteArgs>(
          orElse: () => ViewRestockRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i18.ViewRestockPage(id: args.id, key: args.key)));
    },
    ViewSaleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewSaleRouteArgs>(
          orElse: () => ViewSaleRouteArgs(id: pathParams.getString('id')));
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(
              child: _i19.ViewSalePage(id: args.id, key: args.key)));
    },
    WelcomeRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i20.WelcomePage()));
    },
    Error404Route.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.Error404Page());
    },
    DashboardRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i22.DashboardPage()));
    },
    InventoryRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i23.InventoryPage()));
    },
    MoreRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i24.MorePage()));
    },
    PeopleRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i25.PeoplePage()));
    },
    SalesRoute.name: (routeData) {
      return _i27.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.WrappedRoute(child: const _i26.SalesPage()));
    }
  };

  @override
  List<_i27.RouteConfig> get routes => [
        _i27.RouteConfig(AddCategoryRoute.name, path: 'add-category'),
        _i27.RouteConfig(AddClientRoute.name, path: 'add-client'),
        _i27.RouteConfig(AddInventoryRoute.name, path: 'add-inventory'),
        _i27.RouteConfig(AddLossRoute.name, path: 'add-loss'),
        _i27.RouteConfig(AddRestockRoute.name, path: 'add-restock'),
        _i27.RouteConfig(AddSaleRoute.name, path: 'add-sale'),
        _i27.RouteConfig(EditInventoryRoute.name, path: 'edit-inventory/:id'),
        _i27.RouteConfig(EditLossRoute.name, path: 'edit-loss/:id'),
        _i27.RouteConfig(EditRestockRoute.name, path: 'edit-restock/:id'),
        _i27.RouteConfig(EditSaleRoute.name, path: 'edit-sale/:id'),
        _i27.RouteConfig(LoginRoute.name, path: 'login'),
        _i27.RouteConfig(RegisterRoute.name, path: 'register/:referralId'),
        _i27.RouteConfig(SalesStaffRoute.name, path: 'sales'),
        _i27.RouteConfig(SetupRoute.name, path: 'setup'),
        _i27.RouteConfig(TabRoute.name, path: 'tab', children: [
          _i27.RouteConfig(DashboardRoute.name,
              path: 'inventory', parent: TabRoute.name),
          _i27.RouteConfig(InventoryRoute.name,
              path: 'inventory-tab', parent: TabRoute.name),
          _i27.RouteConfig(MoreRoute.name, path: 'more', parent: TabRoute.name),
          _i27.RouteConfig(PeopleRoute.name,
              path: 'people', parent: TabRoute.name),
          _i27.RouteConfig(SalesRoute.name,
              path: 'sales', parent: TabRoute.name)
        ]),
        _i27.RouteConfig(ViewInventoryRoute.name, path: 'view-inventory/:id'),
        _i27.RouteConfig(ViewLossRoute.name, path: 'view-loss/:id'),
        _i27.RouteConfig(ViewRestockRoute.name, path: 'view-restock/:id'),
        _i27.RouteConfig(ViewSaleRoute.name, path: 'view-sale/:id'),
        _i27.RouteConfig(WelcomeRoute.name, path: '/'),
        _i27.RouteConfig(Error404Route.name, path: '*')
      ];
}

/// generated route for
/// [_i1.AddCategoryPage]
class AddCategoryRoute extends _i27.PageRouteInfo<void> {
  const AddCategoryRoute() : super(AddCategoryRoute.name, path: 'add-category');

  static const String name = 'AddCategoryRoute';
}

/// generated route for
/// [_i2.AddClientPage]
class AddClientRoute extends _i27.PageRouteInfo<AddClientRouteArgs> {
  AddClientRoute({_i28.Key? key})
      : super(AddClientRoute.name,
            path: 'add-client', args: AddClientRouteArgs(key: key));

  static const String name = 'AddClientRoute';
}

class AddClientRouteArgs {
  const AddClientRouteArgs({this.key});

  final _i28.Key? key;

  @override
  String toString() {
    return 'AddClientRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.AddInventoryPage]
class AddInventoryRoute extends _i27.PageRouteInfo<void> {
  const AddInventoryRoute()
      : super(AddInventoryRoute.name, path: 'add-inventory');

  static const String name = 'AddInventoryRoute';
}

/// generated route for
/// [_i4.AddLossPage]
class AddLossRoute extends _i27.PageRouteInfo<void> {
  const AddLossRoute() : super(AddLossRoute.name, path: 'add-loss');

  static const String name = 'AddLossRoute';
}

/// generated route for
/// [_i5.AddRestockPage]
class AddRestockRoute extends _i27.PageRouteInfo<void> {
  const AddRestockRoute() : super(AddRestockRoute.name, path: 'add-restock');

  static const String name = 'AddRestockRoute';
}

/// generated route for
/// [_i6.AddSalePage]
class AddSaleRoute extends _i27.PageRouteInfo<void> {
  const AddSaleRoute() : super(AddSaleRoute.name, path: 'add-sale');

  static const String name = 'AddSaleRoute';
}

/// generated route for
/// [_i7.EditInventoryPage]
class EditInventoryRoute extends _i27.PageRouteInfo<EditInventoryRouteArgs> {
  EditInventoryRoute({required String id, _i28.Key? key})
      : super(EditInventoryRoute.name,
            path: 'edit-inventory/:id',
            args: EditInventoryRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'EditInventoryRoute';
}

class EditInventoryRouteArgs {
  const EditInventoryRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'EditInventoryRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i8.EditLossPage]
class EditLossRoute extends _i27.PageRouteInfo<EditLossRouteArgs> {
  EditLossRoute({required String id, _i28.Key? key})
      : super(EditLossRoute.name,
            path: 'edit-loss/:id',
            args: EditLossRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'EditLossRoute';
}

class EditLossRouteArgs {
  const EditLossRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'EditLossRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i9.EditRestockPage]
class EditRestockRoute extends _i27.PageRouteInfo<EditRestockRouteArgs> {
  EditRestockRoute({required String id, _i28.Key? key})
      : super(EditRestockRoute.name,
            path: 'edit-restock/:id',
            args: EditRestockRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'EditRestockRoute';
}

class EditRestockRouteArgs {
  const EditRestockRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'EditRestockRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i10.EditSalePage]
class EditSaleRoute extends _i27.PageRouteInfo<EditSaleRouteArgs> {
  EditSaleRoute({required String id, _i28.Key? key})
      : super(EditSaleRoute.name,
            path: 'edit-sale/:id',
            args: EditSaleRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'EditSaleRoute';
}

class EditSaleRouteArgs {
  const EditSaleRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'EditSaleRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i11.LoginPage]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i12.RegisterPage]
class RegisterRoute extends _i27.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({required String? referralId, _i28.Key? key})
      : super(RegisterRoute.name,
            path: 'register/:referralId',
            args: RegisterRouteArgs(referralId: referralId, key: key),
            rawPathParams: {'referralId': referralId});

  static const String name = 'RegisterRoute';
}

class RegisterRouteArgs {
  const RegisterRouteArgs({required this.referralId, this.key});

  final String? referralId;

  final _i28.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{referralId: $referralId, key: $key}';
  }
}

/// generated route for
/// [_i13.SalesStaffPage]
class SalesStaffRoute extends _i27.PageRouteInfo<void> {
  const SalesStaffRoute() : super(SalesStaffRoute.name, path: 'sales');

  static const String name = 'SalesStaffRoute';
}

/// generated route for
/// [_i14.SetupPage]
class SetupRoute extends _i27.PageRouteInfo<void> {
  const SetupRoute() : super(SetupRoute.name, path: 'setup');

  static const String name = 'SetupRoute';
}

/// generated route for
/// [_i15.TabPage]
class TabRoute extends _i27.PageRouteInfo<void> {
  const TabRoute({List<_i27.PageRouteInfo>? children})
      : super(TabRoute.name, path: 'tab', initialChildren: children);

  static const String name = 'TabRoute';
}

/// generated route for
/// [_i16.ViewInventoryPage]
class ViewInventoryRoute extends _i27.PageRouteInfo<ViewInventoryRouteArgs> {
  ViewInventoryRoute({required String id, _i28.Key? key})
      : super(ViewInventoryRoute.name,
            path: 'view-inventory/:id',
            args: ViewInventoryRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'ViewInventoryRoute';
}

class ViewInventoryRouteArgs {
  const ViewInventoryRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'ViewInventoryRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i17.ViewLossPage]
class ViewLossRoute extends _i27.PageRouteInfo<ViewLossRouteArgs> {
  ViewLossRoute({required String id, _i28.Key? key})
      : super(ViewLossRoute.name,
            path: 'view-loss/:id',
            args: ViewLossRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'ViewLossRoute';
}

class ViewLossRouteArgs {
  const ViewLossRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'ViewLossRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i18.ViewRestockPage]
class ViewRestockRoute extends _i27.PageRouteInfo<ViewRestockRouteArgs> {
  ViewRestockRoute({required String id, _i28.Key? key})
      : super(ViewRestockRoute.name,
            path: 'view-restock/:id',
            args: ViewRestockRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'ViewRestockRoute';
}

class ViewRestockRouteArgs {
  const ViewRestockRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'ViewRestockRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i19.ViewSalePage]
class ViewSaleRoute extends _i27.PageRouteInfo<ViewSaleRouteArgs> {
  ViewSaleRoute({required String id, _i28.Key? key})
      : super(ViewSaleRoute.name,
            path: 'view-sale/:id',
            args: ViewSaleRouteArgs(id: id, key: key),
            rawPathParams: {'id': id});

  static const String name = 'ViewSaleRoute';
}

class ViewSaleRouteArgs {
  const ViewSaleRouteArgs({required this.id, this.key});

  final String id;

  final _i28.Key? key;

  @override
  String toString() {
    return 'ViewSaleRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i20.WelcomePage]
class WelcomeRoute extends _i27.PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/');

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i21.Error404Page]
class Error404Route extends _i27.PageRouteInfo<void> {
  const Error404Route() : super(Error404Route.name, path: '*');

  static const String name = 'Error404Route';
}

/// generated route for
/// [_i22.DashboardPage]
class DashboardRoute extends _i27.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: 'inventory');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i23.InventoryPage]
class InventoryRoute extends _i27.PageRouteInfo<void> {
  const InventoryRoute() : super(InventoryRoute.name, path: 'inventory-tab');

  static const String name = 'InventoryRoute';
}

/// generated route for
/// [_i24.MorePage]
class MoreRoute extends _i27.PageRouteInfo<void> {
  const MoreRoute() : super(MoreRoute.name, path: 'more');

  static const String name = 'MoreRoute';
}

/// generated route for
/// [_i25.PeoplePage]
class PeopleRoute extends _i27.PageRouteInfo<void> {
  const PeopleRoute() : super(PeopleRoute.name, path: 'people');

  static const String name = 'PeopleRoute';
}

/// generated route for
/// [_i26.SalesPage]
class SalesRoute extends _i27.PageRouteInfo<void> {
  const SalesRoute() : super(SalesRoute.name, path: 'sales');

  static const String name = 'SalesRoute';
}
