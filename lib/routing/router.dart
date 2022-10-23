import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/login/view/view.dart';
import 'package:birdiefy/features/page_not_found/view/view.dart';
import 'package:birdiefy/features/register/view/view.dart';
import 'package:birdiefy/features/round/view/view.dart';
import 'package:birdiefy/features/tab/view/view.dart';
import 'package:birdiefy/features/user/view/view.dart';
import 'package:birdiefy/features/welcome/view/view.dart';
import 'package:birdiefy/routing/guard.dart';

@MaterialAutoRouter(
  preferRelativeImports: false,
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: LoginPage, path: LoginPage.routeName),
    AutoRoute(page: PageNotFoundPage, path: PageNotFoundPage.routeName),
    AutoRoute(page: RegisterPage, path: RegisterPage.routeName),
    AutoRoute(
      guards: [AuthGuard],
      page: RoundPage,
      path: RoundPage.routeName,
    ),
    AutoRoute(
      guards: [AuthGuard],
      page: TabPage,
      path: TabPage.routeName,
    ),
    AutoRoute(
      guards: [AuthGuard],
      page: UserPage,
      path: UserPage.routeName,
    ),
    AutoRoute(page: WelcomePage, initial: true),
    RedirectRoute(path: "*", redirectTo: ""),
  ],
)
class $AppRouter {}
