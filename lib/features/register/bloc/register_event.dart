part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class ConfirmPasswordChanged extends RegisterEvent {
  const ConfirmPasswordChanged({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

class FirstNameChanged extends RegisterEvent {
  const FirstNameChanged({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class HandicapChanged extends RegisterEvent {
  const HandicapChanged({required this.value});
  final String value;

  @override
  List<Object> get props => [value];
}

class LastNameChanged extends RegisterEvent {
  const LastNameChanged({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}

class Register extends RegisterEvent {}

class ToggleConfirmPasswordVisibility extends RegisterEvent {}

class TogglePasswordVisibility extends RegisterEvent {}

class UserTypeChanged extends RegisterEvent {
  const UserTypeChanged({required this.type});
  final UserType type;

  @override
  List<Object> get props => [type];
}
