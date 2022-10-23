part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class BusinessNameChanged extends RegisterEvent {
  const BusinessNameChanged({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class CheckIfPhoneExists extends RegisterEvent {}

class EmailChanged extends RegisterEvent {
  const EmailChanged({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

class EmailFormSubmit extends RegisterEvent {}

class Register extends RegisterEvent {
  const Register({required this.errorStatus, required this.user});
  final Status errorStatus;
  final User user;

  @override
  List<Object> get props => [errorStatus, user];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}

class PhoneNoChanged extends RegisterEvent {
  const PhoneNoChanged({required this.phoneNumber});
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneFormSubmit extends RegisterEvent {}

class SendSMSCode extends RegisterEvent {}

class SubmitError extends RegisterEvent {
  const SubmitError({
    required this.status,
    this.message = 'Something went wrong.',
  });
  final String message;
  final Status status;

  @override
  List<Object> get props => [message, status];
}

class SmsCodeChanged extends RegisterEvent {
  const SmsCodeChanged({required this.code});
  final String code;

  @override
  List<Object> get props => [code];
}

class ToggleRegisterForm extends RegisterEvent {}

class TogglePasswordVisibility extends RegisterEvent {}

class ToggleSmsCode extends RegisterEvent {}

class VerifySMSCode extends RegisterEvent {}
