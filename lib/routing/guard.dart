import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/core/domain/local_data.dart';
import 'package:birdiefy/features/page_not_found/view/view.dart';
import 'package:birdiefy/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final auth = locator<FirebaseAuth>();
    final localData = locator<LocalData>();
    final userData = localData.getString('user');
    if (auth.currentUser == null || userData == null) {
      resolver.next(true);
    } else {
      router.pushNamed(PageNotFoundPage.routeName);
    }
  }
}
