import 'package:birdiefy/core/domain/entity/app_error.dart';
import 'package:birdiefy/features/login/view/view.dart';
import 'package:birdiefy/features/tab/view/view.dart';
import 'package:birdiefy/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<Init>(_init);

    add(Init());
  }
  final _localData = locator<SharedPreferences>();

  Future<void> _init(Init event, Emitter<WelcomeState> emit) async {
    // to showcase the welcome page;
    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = await _getFirebaseUser();
      if (user == null) throw '';

      final userData = _localData.getString('user');
      if (userData == null) throw '';
      emit(
        state.copyWith(
          nextRoute: TabPage.routeName,
          status: Status.loadComplete,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.loadComplete));
    }
  }

  Future<User?> _getFirebaseUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (!kIsWeb || user != null) return user;
    return await FirebaseAuth.instance.authStateChanges().first;
  }
}
