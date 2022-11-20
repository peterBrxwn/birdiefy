// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:birdiefy/features/user/services/repo.dart';
import 'package:birdiefy/injection.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_emailChanged);
    on<Login>(_login);
    on<PasswordChanged>(_passwordChanged);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }
  final _localStorage = locator<SharedPreferences>();

  void _emailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _login(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      // // for email verification: uncomment this block of code.
      // if (!credential.user!.emailVerified) {
      // // resend email verification
      //   credential.user!.sendEmailVerification();
      //   throw 'Please check your email for verification link.';
      // }
      final user = await UserImpl.authLogin(id: credential.user!.uid);
      if (user == null) throw '';
      await _localStorage.setStringList(
        'courses',
        ['Golf course 1', 'Golf course 2', 'Golf course 3', 'Golf course 4'],
      );
      emit(state.copyWith(status: Status.submitSuccess));
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Something went wrong.';
      switch (e.code) {
        case 'network-request-failed':
          errorMsg = 'Network Error. Please check network connection.';
          break;
        case 'user-disabled':
          errorMsg = 'Something went wrong. Please contact support.';
          break;
        case 'user-not-found':
        case 'invalid-email':
        case 'wrong-password':
          errorMsg = 'Invalid login details.';
          break;
      }

      return emit(
        state.copyWith(
          notifMsg: NotifMsg(message: errorMsg),
          status: Status.submitError,
        ),
      );
    } catch (e) {
      final errorMsg = e is String && e.isNotEmpty ? e : 'Something went wrong';
      return emit(
        state.copyWith(
          notifMsg: NotifMsg(message: errorMsg),
          status: Status.submitError,
        ),
      );
    }
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _togglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
