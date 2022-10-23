import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:fiber/features/company/domain/entity/company_entity.dart';
import 'package:fiber/features/company/domain/entity/referral_entity.dart';
import 'package:fiber/features/company/services/models/currency_model.dart';
import 'package:fiber/features/company/services/repo.dart';
import 'package:fiber/features/company_settings/domain/entity/company_settings.dart';
import 'package:fiber/features/company_settings/services/repo.dart';
import 'package:fiber/core/domain/entity/notif_msg.dart';
import 'package:fiber/utils/string_utils.dart';
import 'package:fiber/core/services/constants.dart';
import 'package:fiber/features/device/domain/entity/device_entity.dart';
import 'package:fiber/features/device/services/models/device_model.dart';
import 'package:fiber/features/device/services/repo.dart';
import 'package:fiber/features/staff/domain/entity/person_base_entity.dart';
import 'package:fiber/features/staff/domain/entity/staff_entity.dart';
import 'package:fiber/features/staff/services/repo.dart';
import 'package:fiber/features/staff_setting/domain/entity/staff_setting_entity.dart';
import 'package:fiber/features/staff_setting/services/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platform_device_id/platform_device_id.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required String referralId,
    required bool showPhoneRegister,
  }) : super(
          RegisterState(
            referralId: referralId,
            showPhoneRegister: showPhoneRegister,
          ),
        ) {
    on<BusinessNameChanged>(_businessNameChanged);
    on<CheckIfPhoneExists>(_checkIfPhoneExists);
    on<EmailChanged>(_emailChanged);
    on<EmailFormSubmit>(_emailFormSubmit);
    on<Register>(_register);
    on<PasswordChanged>(_passwordChanged);
    on<PhoneNoChanged>(_phoneNoChanged);
    on<PhoneFormSubmit>(_phoneFormSubmit);
    on<SendSMSCode>(_sendSMSCode);
    on<SmsCodeChanged>(_smsCodeChanged);
    on<SubmitError>(_submitError);
    on<ToggleRegisterForm>(_toggleRegisterForm);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
    on<ToggleSmsCode>(_toggleSmsCode);
    on<VerifySMSCode>(_verifySMSCode);
  }

  void _businessNameChanged(
    BusinessNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(businessName: event.name));
  }

  Future<void> _checkIfPhoneExists(
    CheckIfPhoneExists event,
    Emitter<RegisterState> emit,
  ) async {
    final callable = FirebaseFunctions.instance
        .httpsCallable('user-user-checkIfPhoneExists');
    try {
      final result = await callable.call({'phone': state.phoneNumber});
      if (!(result.data as bool)) return add(SendSMSCode());
      return add(
        const SubmitError(
          message: 'Phone number already in use. Please login.',
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
      add(
        Register(
          errorStatus: Status.emailSubmitError,
          user: credential.user!,
        ),
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
      add(SubmitError(message: errorMsg, status: Status.emailSubmitError));
    } catch (e) {
      return add(
        const SubmitError(
          message: 'Something went wrong',
          status: Status.emailSubmitError,
        ),
      );
    }
  }

  Future<void> _register(Register event, Emitter<RegisterState> emit) async {
    try {
      final uid = event.user.uid;
      final company = Company(
        address: '',
        currency: CurrencyModel.fromJson(defaultCurrency),
        dateAdded: DateTime.now(),
        logo: '',
        name: state.businessName,
        paid: true,
        phoneNo: state.phoneNumber,
        phoneNo_1: '',
        referral: Referral(id: state.referralId),
        staffIds: [uid],
      );
      final res = await CompanyImpl.authRegister(company: company);
      String companyId = '';
      res.fold((l) => throw '', (r) => companyId = r);

      final staff = Staff(
        access: true,
        dateAdded: DateTime.now(),
        email: state.email,
        id: uid,
        name: 'User',
        phoneNo: state.phoneNumber,
        staff: const PersonBase(id: '', name: 'AUTO'),
        type: StaffType.admin,
      );
      final staffRes =
          await StaffImpl.authRegister(companyId: companyId, staff: staff);
      if (staffRes.isLeft()) throw '';

      final staffSettingRes = await StaffSettingImpl.authRegister(
        companyId: companyId,
        staffId: uid,
        staffSetting: const StaffSetting(printAfterSale: true),
      );
      if (staffSettingRes.isLeft()) throw '';

      final companySettings = CompanySettings(
        goodbyeText: 'Thank you for coming.',
        includeVat: false,
        editableProductName: true,
        editableProductPrice: true,
        allowQuickAdd: true,
        debtsForOnlyExistingClients: false,
        showStaffSalesSummary: true,
        allowDebt: true,
        allowDiscount: true,
      );
      final companySettingsRes = await CompanySettingsImpl.authRegister(
        companyId: companyId,
        companySettings: companySettings,
      );
      if (companySettingsRes.isLeft()) throw '';

      final deviceId =
          StringUtils.removeSlash((await PlatformDeviceId.getDeviceId)!);
      final device = Device(staffId: uid, deviceId: deviceId, lastReceiptId: 0);
      final deviceRes = await DeviceImpl.authRegister(
        device: device,
        companyId: companyId,
      );
      if (deviceRes.isLeft()) throw '';

      if (event.errorStatus != Status.phoneNoSubmitError) {
        event.user.sendEmailVerification();
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
          status: Status.registerSuccess,
        ),
      );
      // await FcmUtils.init();
      // _aCtrl.initData();
      // await _aCtrl.ready.future;
    } catch (e) {
      return emit(
        state.copyWith(
          notifMsg: NotifMsg(),
          status: event.errorStatus,
        ),
      );
    }
  }

  Future<void> _sendSMSCode(
    SendSMSCode event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: state.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (authCredential) async {
          final credential =
              await FirebaseAuth.instance.signInWithCredential(authCredential);
          add(
            Register(
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
              notifMsg: NotifInfo(
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

  void _passwordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _phoneNoChanged(PhoneNoChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _phoneFormSubmit(PhoneFormSubmit event, Emitter<RegisterState> emit) {
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

  void _smsCodeChanged(SmsCodeChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(smsCode: event.code.trim()));
  }

  void _submitError(SubmitError event, Emitter<RegisterState> emit) {
    return emit(
      state.copyWith(
        notifMsg: NotifMsg(message: event.message),
        status: event.status,
      ),
    );
  }

  void _toggleRegisterForm(
    ToggleRegisterForm event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        showPhoneRegister: !state.showPhoneRegister,
        showSmsCode: false,
      ),
    );
  }

  void _togglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _toggleSmsCode(ToggleSmsCode event, Emitter<RegisterState> emit) {
    emit(state.copyWith(showSmsCode: !state.showSmsCode));
  }

  Future<void> _verifySMSCode(
    VerifySMSCode event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      final authCredential = PhoneAuthProvider.credential(
        verificationId: state.verificationId,
        smsCode: state.smsCode,
      );
      final credential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      add(
        Register(
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
