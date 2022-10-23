part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AppSettingsChanged extends LoginEvent {
  const AppSettingsChanged({required this.appSettings});
  final AppSettings appSettings;

  @override
  List<Object> get props => [appSettings];
}

class CheckIfPhoneExists extends LoginEvent {}

class EmailChanged extends LoginEvent {
  const EmailChanged({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

class EmailFormSubmit extends LoginEvent {}

class Login extends LoginEvent {
  const Login({required this.errorStatus, required this.user});
  final Status errorStatus;
  final User user;

  @override
  List<Object> get props => [errorStatus, user];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}

class PhoneNoChanged extends LoginEvent {
  const PhoneNoChanged({required this.phoneNumber});
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneFormSubmit extends LoginEvent {}

class SendSMSCode extends LoginEvent {}

class SmsCodeChanged extends LoginEvent {
  const SmsCodeChanged({required this.code});
  final String code;

  @override
  List<Object> get props => [code];
}

class SubmitError extends LoginEvent {
  const SubmitError({
    required this.status,
    this.message = 'Something went wrong.',
  });
  final String message;
  final Status status;

  @override
  List<Object> get props => [message, status];
}

class ToggleLoginForm extends LoginEvent {}

class TogglePasswordVisibility extends LoginEvent {}

class ToggleSmsCode extends LoginEvent {}

class VerifySMSCode extends LoginEvent {}
