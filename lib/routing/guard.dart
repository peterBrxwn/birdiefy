// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:birdiefy/features/login/view/view.dart';
import 'package:birdiefy/injection.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final auth = locator<FirebaseAuth>();
    if (auth.currentUser != null) {
      resolver.next(true);
    } else {
      router.pushNamed(LoginPage.routeName);
    }
  }
}
