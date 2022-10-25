import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/domain/entity/user_type.dart';
import 'package:birdiefy/features/user/services/repo.dart';
import 'package:birdiefy/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<EmailChanged>(_emailChanged);
    on<FirstNameChanged>(_firstNameChanged);
    on<HandicapChanged>(_handicapChanged);
    on<LastNameChanged>(_lastNameChanged);
    on<PasswordChanged>(_passwordChanged);
    on<Register>(_register);
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

  void _firstNameChanged(FirstNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(firstname: event.name));
  }

  void _handicapChanged(HandicapChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(handicap: event.value));
  }

  void _lastNameChanged(LastNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(lastname: event.name));
  }

  void _passwordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _register(Register event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (state.userType == null) {
        throw 'Please select a user type [Player or Coach]';
      }

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      // send email for verification
      // await credential.user!.sendEmailVerification();

      final user = User(
        dateAdded: DateTime.now(),
        email: state.email,
        firstname: state.firstname,
        handicap: state.handicap,
        id: credential.user!.uid,
        lastname: state.lastname,
        userType: state.userType!,
      );
      final result = await UserImpl.authRegister(user: user);
      result.fold(
        (l) => throw l.message,
        (r) async {
          await _localData.setStringList(
            'courses',
            [
              'Golf course 1',
              'Golf course 2',
              'Golf course 3',
              'Golf course 4',
            ],
          );
          emit(state.copyWith(status: Status.submitSuccess));
        },
      );
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
      return emit(
        state.copyWith(
          notifMsg: NotifMsg(message: errorMsg),
          status: Status.submitError,
        ),
      );
    } catch (e) {
      return emit(
        state.copyWith(
          notifMsg: NotifMsg(
            message: e is String && e.isNotEmpty ? e : 'Something went wrong',
          ),
          status: Status.submitError,
        ),
      );
    }
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
