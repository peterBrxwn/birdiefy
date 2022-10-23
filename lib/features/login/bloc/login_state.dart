part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.hidePassword = true,
    this.notifMsg,
    this.password = '',
    this.status = Status.initial,
  });
  final String email;
  final bool hidePassword;
  final NotifMsg? notifMsg;
  final String password;
  final Status status;

  LoginState copyWith({
    String? email,
    bool? hidePassword,
    NotifMsg? notifMsg,
    String? password,
    Status? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      hidePassword: hidePassword ?? this.hidePassword,
      notifMsg: notifMsg,
      password: password ?? this.password,
      status: status ?? Status.initial,
    );
  }

  @override
  List<Object?> get props => [
        email,
        hidePassword,
        notifMsg,
        password,
        status,
      ];
}

enum Status {
  emailSubmitError,
  initial,
  loading,
  loginSuccess,
}
