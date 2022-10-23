import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/domain/entity/user_type.dart';
import 'package:birdiefy/features/user/services/models/user_model.dart';
import 'package:birdiefy/features/user/services/repo.dart';
import 'package:birdiefy/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(
          const RegisterState(),
        ) {
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<EmailChanged>(_emailChanged);
    on<EmailFormSubmit>(_emailFormSubmit);
    on<FirstNameChanged>(_firstNameChanged);
    on<LastNameChanged>(_lastNameChanged);
    on<PasswordChanged>(_passwordChanged);
    on<SubmitError>(_submitError);
    on<ToggleConfirmPasswordVisibility>(_toggleConfirmPasswordVisibility);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
    on<UserTypeChanged>(_userTypeChanged);
  }
  final _localData = locator<SharedPreferences>();

  void _confirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.password));
  }

  void _emailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _emailFormSubmit(
    EmailFormSubmit event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      final uid = credential.user!.uid;

      final user = User(
        dateAdded: DateTime.now(),
        email: state.email,
        firstname: state.firstname,
        handicap: state.handicap,
        id: uid,
        lastname: 'User',
        userType: state.userType!,
      );
      final userRes = await UserImpl.authRegister(user: user);
      if (userRes.isLeft()) throw '';

      await _localData.setString(
        'user',
        UserModel.fromEntity(user).toJsonString(),
      );
      emit(state.copyWith(status: Status.submitSuccess));
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Something went wrong.';
      switch (e.code) {
        case 'network-request-failed':
          errorMsg = 'Network Error. Please check network connection.';
          break;
        case 'weak-password':
          errorMsg = 'Your password is too weak';
          break;
        case 'invalid-email':
          errorMsg = 'Your email is invalid';
          break;
        case 'email-already-in-use':
          errorMsg = 'Email is already in use on different account';
          break;
      }
      add(SubmitError(message: errorMsg, status: Status.submitError));
    } catch (e) {
      return add(
        const SubmitError(
          message: 'Something went wrong',
          status: Status.submitError,
        ),
      );
    }
  }

  void _firstNameChanged(
    FirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(firstname: event.name));
  }

  void _lastNameChanged(
    LastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(lastname: event.name));
  }

  void _passwordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _submitError(SubmitError event, Emitter<RegisterState> emit) {
    return emit(
      state.copyWith(
        notifMsg: NotifMsg(message: event.message),
        status: event.status,
      ),
    );
  }

  void _toggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(hideConfirmPassword: !state.hideConfirmPassword));
  }

  void _togglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _userTypeChanged(UserTypeChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(userType: event.type));
  }
}
