import 'dart:async';

import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_emailChanged);
    on<EmailFormSubmit>(_emailFormSubmit);
    on<PasswordChanged>(_passwordChanged);
    on<SubmitError>(_submitError);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }

  void _emailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _emailFormSubmit(
    EmailFormSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      if (!credential.user!.emailVerified) {
        credential.user!.sendEmailVerification();
        throw 'Please check your email for verification link.';
      }
    emit(state.copyWith(status: Status.loginSuccess));
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
      add(SubmitError(message: errorMsg, status: Status.emailSubmitError));
    } catch (e) {
      return add(
        SubmitError(
          message: e is String ? e : 'Something went wrong',
          status: Status.emailSubmitError,
        ),
      );
    }
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _submitError(SubmitError event, Emitter<LoginState> emit) {
    return emit(
      state.copyWith(
        notifMsg: NotifMsg(message: event.message),
        status: event.status,
      ),
    );
  }

  void _togglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
