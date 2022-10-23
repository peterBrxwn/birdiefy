part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.showPhoneLogin,
    this.appData,
    this.company,
    this.device,
    this.email = '',
    this.hidePassword = true,
    this.nextRoute,
    this.notifMsg,
    this.password = '',
    this.phoneNumber = '',
    this.showSmsCode = false,
    this.smsCode = '',
    this.staff,
    this.status = Status.initial,
    this.uniqueReceiptId,
    this.verificationId = '',
  });
  final List<String>? appData;
  final Company? company;
  final Device? device;
  final String email;
  final bool hidePassword;
  final String? nextRoute;
  final NotifMsg? notifMsg;
  final String password;
  final String phoneNumber;
  final bool showPhoneLogin;
  final bool showSmsCode;
  final String smsCode;
  final Staff? staff;
  final Status status;
  final int? uniqueReceiptId;
  final String verificationId;

  LoginState copyWith({
    List<String>? appData,
    AppSettings? appSettings,
    Company? company,
    Device? device,
    String? email,
    bool? hidePassword,
    String? nextRoute,
    NotifMsg? notifMsg,
    String? password,
    String? phoneNumber,
    bool? showPhoneLogin,
    bool? showSmsCode,
    String? smsCode,
    Staff? staff,
    Status? status,
    int? uniqueReceiptId,
    String? verificationId,
  }) {
    return LoginState(
      appData: appData ?? this.appData,
      company: company ?? this.company,
      device: device ?? this.device,
      email: email ?? this.email,
      hidePassword: hidePassword ?? this.hidePassword,
      nextRoute: nextRoute ?? this.nextRoute,
      notifMsg: notifMsg,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      showPhoneLogin: showPhoneLogin ?? this.showPhoneLogin,
      showSmsCode: showSmsCode ?? this.showSmsCode,
      smsCode: smsCode ?? this.smsCode,
      staff: staff ?? this.staff,
      status: status ?? Status.initial,
      uniqueReceiptId: uniqueReceiptId ?? this.uniqueReceiptId,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  List<Object?> get props => [
        appData,
        company,
        device,
        email,
        hidePassword,
        nextRoute,
        notifMsg,
        password,
        phoneNumber,
        showPhoneLogin,
        showSmsCode,
        smsCode,
        staff,
        status,
        uniqueReceiptId,
        verificationId,
      ];
}

enum Status {
  emailSubmitError,
  initBlocs,
  initial,
  loading,
  loginSuccess,
  phoneNoSubmitError,
  resetPhoneForm,
  unfocusPinPut,
}
