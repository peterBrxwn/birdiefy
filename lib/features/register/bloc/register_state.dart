part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    required this.referralId,
    required this.showPhoneRegister,
    this.appData,
    this.businessName = '',
    this.company,
    this.device,
    this.email = '',
    this.hidePassword = false,
    this.notifMsg,
    this.password = '',
    this.phoneNumber = '',
    this.showSmsCode = false,
    this.smsCode = '',
    this.staff,
    this.status = Status.initial,
    this.verificationId = '',
  });
  final List<String>? appData;
  final String businessName;
  final Company? company;
  final Device? device;
  final String email;
  final bool hidePassword;
  final NotifMsg? notifMsg;
  final String password;
  final String phoneNumber;
  final String referralId;
  final bool showPhoneRegister;
  final bool showSmsCode;
  final String smsCode;
  final Staff? staff;
  final Status status;
  final String verificationId;

  RegisterState copyWith({
    List<String>? appData,
    String? businessName,
    Company? company,
    Device? device,
    String? deviceId,
    String? email,
    bool? hidePassword,
    NotifMsg? notifMsg,
    String? password,
    String? phoneNumber,
    String? referralId,
    bool? showPhoneRegister,
    bool? showSmsCode,
    String? smsCode,
    Staff? staff,
    Status? status,
    String? verificationId,
  }) {
    return RegisterState(
      appData: appData ?? this.appData,
      businessName: businessName ?? this.businessName,
      company: company ?? this.company,
      device: device ?? this.device,
      email: email ?? this.email,
      hidePassword: hidePassword ?? this.hidePassword,
      notifMsg: notifMsg,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      referralId: referralId ?? this.referralId,
      showPhoneRegister: showPhoneRegister ?? this.showPhoneRegister,
      showSmsCode: showSmsCode ?? this.showSmsCode,
      smsCode: smsCode ?? this.smsCode,
      staff: staff ?? this.staff,
      status: status ?? this.status,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  List<Object?> get props => [
        appData,
        businessName,
        company,
        device,
        email,
        hidePassword,
        notifMsg,
        password,
        phoneNumber,
        referralId,
        showPhoneRegister,
        showSmsCode,
        smsCode,
        staff,
        status,
        verificationId,
      ];
}

enum Status {
  emailSubmitError,
  initial,
  loading,
  registerSuccess,
  phoneNoSubmitError,
  resetPhoneForm,
  unfocusPinPut,
}
