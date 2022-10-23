part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.confirmPassword = '',
    this.email = '',
    this.firstname = '',
    this.handicap = '',
    this.hidePassword = false,
    this.lastname = '',
    this.notifMsg,
    this.password = '',
    this.status = Status.initial,
    this.userType,
  });
  final String confirmPassword;
  final String email;
  final String firstname;
  final String handicap;
  final bool hidePassword;
  final String lastname;
  final NotifMsg? notifMsg;
  final String password;
  final Status status;
  final UserType? userType;

  RegisterState copyWith({
    String? confirmPassword,
    String? email,
    String? firstname,
    String? handicap,
    bool? hidePassword,
    String? lastname,
    NotifMsg? notifMsg,
    String? password,
    Status? status,
    UserType? userType,
  }) {
    return RegisterState(
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      handicap: handicap ?? this.handicap,
      hidePassword: hidePassword ?? this.hidePassword,
      lastname: lastname ?? this.lastname,
      notifMsg: notifMsg,
      password: password ?? this.password,
      status: status ?? this.status,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [
        confirmPassword,
        email,
        firstname,
        handicap,
        hidePassword,
        lastname,
        notifMsg,
        password,
        status,
        userType,
      ];
}

enum Status {
  submitError,
  initial,
  loading,
  submitSuccess,
}
