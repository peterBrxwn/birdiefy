import 'dart:async';
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:fiber/injection.dart';
import 'package:fiber/features/app_settings/domain/entity/app_settings_entity.dart';
import 'package:fiber/features/app_settings/services/repo.dart';
import 'package:fiber/features/company/domain/entity/company_entity.dart';
import 'package:fiber/features/company/services/repo.dart';
import 'package:fiber/core/domain/entity/notif_msg.dart';
import 'package:fiber/utils/string_utils.dart';
import 'package:fiber/core/services/constants.dart';
import 'package:fiber/features/device/domain/entity/device_entity.dart';
import 'package:fiber/features/device/services/models/device_model.dart';
import 'package:fiber/features/device/services/repo.dart';
import 'package:fiber/features/sales_staff/view/view.dart';
import 'package:fiber/features/setup/view/view.dart';
import 'package:fiber/features/staff/domain/entity/staff_entity.dart';
import 'package:fiber/features/staff/services/repo.dart';
import 'package:fiber/features/tab/view/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required bool showPhoneLogin})
      : super(LoginState(showPhoneLogin: showPhoneLogin)) {
    on<AppSettingsChanged>(_appSettingsChanged);
    on<CheckIfPhoneExists>(_checkIfPhoneExists);
    on<EmailChanged>(_emailChanged);
    on<EmailFormSubmit>(_emailFormSubmit);
    on<Login>(_login);
    on<PasswordChanged>(_passwordChanged);
    on<PhoneNoChanged>(_phoneNoChanged);
    on<PhoneFormSubmit>(_phoneFormSubmit);
    on<SendSMSCode>(_sendSMSCode);
    on<SmsCodeChanged>(_smsCodeChanged);
    on<SubmitError>(_submitError);
    on<ToggleLoginForm>(_toggleLoginForm);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
    on<ToggleSmsCode>(_toggleSmsCode);
    on<VerifySMSCode>(_verifySMSCode);
  }
  final _localData = locator<SharedPreferences>();

  void _appSettingsChanged(AppSettingsChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(appSettings: event.appSettings));
  }

  Future<void> _checkIfPhoneExists(
    CheckIfPhoneExists event,
    Emitter<LoginState> emit,
  ) async {
    final callable = FirebaseFunctions.instance
        .httpsCallable('user-user-checkIfPhoneExists');
    try {
      final result = await callable.call({'phone': state.phoneNumber});
      if (result.data as bool) return add(SendSMSCode());
      return add(
        const SubmitError(
          message: 'No User found with this phone number',
          status: Status.phoneNoSubmitError,
        ),
      );
    } on FirebaseFunctionsException catch (e) {
      return add(
        SubmitError(
          message: e.message ?? 'Something went wrong.',
          status: Status.phoneNoSubmitError,
        ),
      );
    } catch (_) {}
    return add(const SubmitError(status: Status.phoneNoSubmitError));
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
      add(Login(errorStatus: Status.emailSubmitError, user: credential.user!));
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

  String _getNextPage() {
    if (state.staff!.isStaff) return SalesStaffPage.routeName;
    if (state.staff!.isAdmin && state.staff!.name == 'User') {
      return SetupPage.routeName;
    }
    return TabPage.routeName;
  }

  Future<bool> _isSubscribed() async {
    final purchaserInfo = await Purchases.getCustomerInfo();
    for (final eId in plansEId) {
      if (purchaserInfo.entitlements.all[eId] != null) {
        return purchaserInfo.entitlements.all[eId]!.isActive;
      }
    }
    return false;
  }

  Future<void> _login(Login event, Emitter<LoginState> emit) async {
    bool hasExpired = false;

    try {
      final uid = event.user.uid;
      final companies = await CompanyImpl.companies(uid);
      if (companies.isEmpty) {
        throw 'Something went wrong. Please contact support.';
      }

      companies.sort((a, b) {
        if (a.dateAdded == null) return 1;
        if (b.dateAdded == null) return 0;
        return a.dateAdded!.compareTo(b.dateAdded!);
      });
      if (companies.length > 1) {
        final companyId = _localData.getString(rememberMeKey + uid);
        if (companyId != null) {
          final rememberMeIndex =
              companies.indexWhere((element) => element.id == companyId);
          if (rememberMeIndex != -1) {
            companies.insert(0, companies.removeAt(rememberMeIndex));
          }
        }
      }

      final appSettings = await AppSettingsImpl.appSettings();
      final allowAdmin = appSettings!.allowAdminFree;
      Company? company;
      for (final companyCheck in companies) {
        if (!companyCheck.paid && !(allowAdmin && companyCheck.isAdmin(uid))) {
          await Purchases.logIn(companyCheck.id!);
          if (!await _isSubscribed()) continue;
        }
        company = companyCheck;
        break;
      }
      if (company == null) {
        hasExpired = true;
        company = companies.first;
      }

      final staff =
          await StaffImpl.auth(id: event.user.uid, companyId: company.id!);
      if (staff == null) {
        throw 'This account has been deactivated. Please contact Business '
            'owner.';
      }

      final deviceId =
          StringUtils.removeSlash((await PlatformDeviceId.getDeviceId)!);
      Device? device = await DeviceImpl.auth(
        companyId: company.id!,
        deviceId: deviceId,
        staffId: uid,
      );
      if (device == null) {
        device = Device(
          deviceId: deviceId,
          lastReceiptId: 0,
          staffId: uid,
          index: -1,
        );
        final deviceRes = await DeviceImpl.authRegister(
          device: device,
          companyId: company.id!,
        );
        if (deviceRes.isLeft()) throw '';
      }

      final appData = [
        company.id!,
        json.encode(staff),
        json.encode(DeviceModel.fromEntity(device)),
        json.encode(company),
      ];
      emit(
        state.copyWith(
          appData: appData,
          company: company,
          device: device,
          staff: staff,
          status: Status.initBlocs,
        ),
      );

      if (hasExpired) throw '';

      // await FcmUtils.init();
      // _aCtrl.initData();
      // await _aCtrl.ready.future;
    } catch (e) {
      if (hasExpired == true) {
        return emit(
          state.copyWith(
            notifMsg: const NotifMsg(
              message: 'Subscription has expired. Redirecting...',
            ),
            nextRoute: 'fiber-payment',
            status: Status.loginSuccess,
          ),
        );
      }
      return emit(
        state.copyWith(
          notifMsg: NotifMsg(
            message: e is String && e.isNotEmpty ? e : 'Something went wrong.',
          ),
          status: event.errorStatus,
        ),
      );
    }

    emit(
      state.copyWith(
        nextRoute: _getNextPage(),
        status: Status.loginSuccess,
      ),
    );
  }

  Future<void> _sendSMSCode(SendSMSCode event, Emitter<LoginState> emit) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: state.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (authCredential) async {
          final credential =
              await FirebaseAuth.instance.signInWithCredential(authCredential);
          add(
            Login(
              errorStatus: Status.phoneNoSubmitError,
              user: credential.user!,
            ),
          );
        },
        verificationFailed: (e) {
          return add(
            SubmitError(
              message: e.message ?? 'Something went wrong.',
              status: Status.phoneNoSubmitError,
            ),
          );
        },
        codeSent: (verificationId, [forceResendingToken]) {
          emit(
            state.copyWith(
              notifMsg: const NotifInfo(
                message: 'Please enter the code sent to your phone.',
              ),
              showSmsCode: true,
              status: Status.resetPhoneForm,
              verificationId: verificationId,
            ),
          );
        },
        codeAutoRetrievalTimeout: (_) {
          return add(const SubmitError(status: Status.phoneNoSubmitError));
        },
      );
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Something went wrong';
      switch (e.code) {
        case 'network-request-failed':
          errorMsg = 'Network Error. Please check network connection.';
          break;
      }
      return add(
        SubmitError(message: errorMsg, status: Status.phoneNoSubmitError),
      );
    } catch (e) {
      return add(const SubmitError(status: Status.phoneNoSubmitError));
    }
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _phoneNoChanged(PhoneNoChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _phoneFormSubmit(PhoneFormSubmit event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: Status.loading));

    if (state.phoneNumber.isEmpty) {
      return add(
        const SubmitError(
          message: 'Enter your phone number',
          status: Status.phoneNoSubmitError,
        ),
      );
    }

    if (!state.showSmsCode) return add(CheckIfPhoneExists());
    emit(state.copyWith(status: Status.unfocusPinPut));
    if (state.smsCode.length != 6) {
      return add(
        const SubmitError(
          message: 'Invalid SMS Code',
          status: Status.phoneNoSubmitError,
        ),
      );
    }
    return add(VerifySMSCode());
  }

  void _smsCodeChanged(SmsCodeChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(smsCode: event.code.trim()));
  }

  void _submitError(SubmitError event, Emitter<LoginState> emit) {
    return emit(
      state.copyWith(
        notifMsg: NotifMsg(message: event.message),
        status: event.status,
      ),
    );
  }

  void _toggleLoginForm(ToggleLoginForm event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        showPhoneLogin: !state.showPhoneLogin,
        showSmsCode: false,
      ),
    );
  }

  void _togglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _toggleSmsCode(ToggleSmsCode event, Emitter<LoginState> emit) {
    emit(state.copyWith(showSmsCode: !state.showSmsCode));
  }

  Future<void> _verifySMSCode(
    VerifySMSCode event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final authCredential = PhoneAuthProvider.credential(
        verificationId: state.verificationId,
        smsCode: state.smsCode,
      );
      final credential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      add(
        Login(
          errorStatus: Status.phoneNoSubmitError,
          user: credential.user!,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMsg = e.message ?? 'Something went wrong';
      switch (e.code) {
        case 'network-request-failed':
          errorMsg = 'Network Error. Please check network connection.';
          break;
        case 'user-disabled':
          errorMsg = 'Account disabled. Please contact support.';
          break;
      }
      SubmitError(message: errorMsg, status: Status.phoneNoSubmitError);
    } catch (e) {
      const SubmitError(status: Status.phoneNoSubmitError);
    }
  }
}
