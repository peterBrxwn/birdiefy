import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/login/view/view.dart';
import 'package:birdiefy/features/register/view/view.dart';

@MaterialAutoRouter(
  preferRelativeImports: false,
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: LoginPage, path: LoginPage.routeName),
    AutoRoute(page: RegisterPage, path: RegisterPage.routeName),
  ],
)
class $AppRouter {}
