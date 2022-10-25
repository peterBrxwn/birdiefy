import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/add_round/view/view.dart';
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
    AutoRoute(
      guards: [AuthGuard],
      page: AddRoundPage,
      path: AddRoundPage.routeName,
    ),
    AutoRoute(page: LoginPage, path: LoginPage.routeName),
    AutoRoute(page: PageNotFoundPage, path: PageNotFoundPage.routeName),
    AutoRoute(page: RegisterPage, path: RegisterPage.routeName),
    AutoRoute(
      children: [
        AutoRoute(
          guards: [AuthGuard],
          page: RoundPage,
          path: RoundPage.routeName,
        ),
        AutoRoute(
          guards: [AuthGuard],
          page: UserPage,
          path: UserPage.routeName,
        ),
      ],
      guards: [AuthGuard],
      page: TabPage,
      path: TabPage.routeName,
    ),
    AutoRoute(page: WelcomePage, initial: true),
    RedirectRoute(path: "*", redirectTo: ""),
  ],
)
class $AppRouter {}
