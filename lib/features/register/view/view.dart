import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fiber/features/app_data/bloc/app_data_bloc.dart';
import 'package:fiber/core/domain/ext.dart';
import 'package:fiber/utils/string_utils.dart';
import 'package:fiber/utils/app_theme.dart';
import 'package:fiber/core/services/constants.dart';
import 'package:fiber/core/services/auth_helper.dart';
import 'package:fiber/shared/input_decoration.dart';
import 'package:fiber/core/view/notify.dart';
import 'package:fiber/shared/buttons/loading_lg_button.dart';
import 'package:fiber/shared/company_logo.dart';
import 'package:fiber/shared/dialog.dart';
import 'package:fiber/shared/link_text_span.dart';
import 'package:fiber/shared/remove_focus.dart';
import 'package:fiber/features/login/view/view.dart';
import 'package:fiber/features/register/bloc/register_bloc.dart';
import 'package:fiber/features/setup/view/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatelessWidget implements AutoRouteWrapper {
  const RegisterPage({
    @PathParam('referralId') required this.referralId,
    Key? key,
  }) : super(key: key);
  final String? referralId;

  static const routeName = 'register';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return RegisterBloc(
          referralId: referralId ?? 'default',
          showPhoneRegister: !kIsWeb,
        );
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.notifMsg != null) {
              Notify.generic(
                context,
                state.notifMsg!.type,
                state.notifMsg!.message,
              );
            }
          },
        ),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RemoveFocus(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 20),
                    const CompanyLogo(),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'CREATE A BUSINESS',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const _CreateAccount(),
                    const SizedBox(height: 20),
                    const _Form(),
                    const SizedBox(height: 40),
                    const _RegisterWith(),
                    const SizedBox(height: 20),
                    const _StaffAccount(),
                    const SizedBox(height: 20),
                    const _Footer(),
                    Row(
                      children: const [
                        Text('©2021 All Rights Reserved.'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccount extends StatelessWidget {
  const _CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.pushNamed(LoginPage.routeName),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: 'Already have an account?',
              children: <TextSpan>[
                TextSpan(
                  text: ' Sign In.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: state.showPhoneRegister
              ? _PhoneRegisterForm(formKey: _formKey)
              : _EmailRegisterForm(formKey: _formKey),
        );
      },
    );
  }
}

class _PhoneRegisterForm extends StatelessWidget {
  const _PhoneRegisterForm({required this.formKey, Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!state.showSmsCode) const _BusinessNameInput(),
            if (!state.showSmsCode) const SizedBox(height: 10),
            if (!state.showSmsCode)
              IntlPhoneField(
                initialValue: state.phoneNumber,
                decoration: const FiberInputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(14),
                ],
                initialCountryCode: 'NG',
                onChanged: (value) {
                  context
                      .read<RegisterBloc>()
                      .add(PhoneNoChanged(phoneNumber: value.completeNumber));
                },
              ),
            if (!state.showSmsCode) const SizedBox(height: 10),
            if (state.showSmsCode) const _PinPut(),
            if (state.showSmsCode)
              Text(
                'Enter SMS code',
                style: Theme.of(context).textTheme.overline,
              ),
            const SizedBox(height: 20),
            _PhoneRegisterButton(formKey: formKey),
          ],
        );
      },
    );
  }
}

class _PinPut extends StatefulWidget {
  const _PinPut({Key? key}) : super(key: key);

  @override
  State<_PinPut> createState() => _PinPutState();
}

class _PinPutState extends State<_PinPut> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        final defaultPinTheme = PinTheme(
          decoration: BoxDecoration(
            color: AppTheme.adaptiveGrey(state.isDarkMode),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.transparent),
          ),
        );

        return BlocListener<RegisterBloc, RegisterState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == Status.unfocusPinPut) _focusNode.unfocus();
            if (state.status == Status.resetPhoneForm) _controller.clear();
          },
          child: Pinput(
            length: 6,
            validator: (s) {
              if (s!.length != 6) return 'Invalid Code';
              return null;
            },
            focusNode: _focusNode,
            controller: _controller,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              height: 68,
              width: 64,
              decoration: defaultPinTheme.decoration!.copyWith(
                // border: Border.all(color: borderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                color: Theme.of(context).errorColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            autofocus: true,
            onChanged: (value) {
              context.read<RegisterBloc>().add(SmsCodeChanged(code: value));
            },
            keyboardAppearance:
                context.isDarkMode ? Brightness.dark : Brightness.light,
            pinAnimationType: PinAnimationType.scale,
          ),
        );
      },
    );
  }
}

class _PhoneRegisterButton extends StatefulWidget {
  const _PhoneRegisterButton({required this.formKey, Key? key})
      : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<_PhoneRegisterButton> createState() => _PhoneRegisterButtonState();
}

class _PhoneRegisterButtonState extends State<_PhoneRegisterButton> {
  final _buttonController = RoundedLoadingButtonController();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.phoneNoSubmitError) {
          _buttonController.error();
          _timer = Timer(
            const Duration(seconds: 3),
            _buttonController.reset,
          );
        }
        if (state.status == Status.resetPhoneForm) {
          _buttonController.reset();
        }
        if (state.status == Status.registerSuccess) {
          initBlocs(
            appData: state.appData,
            context: context,
            company: state.company!,
            device: state.device!,
            staff: state.staff!,
          );
          _buttonController.success();
          _timer = Timer(
            const Duration(seconds: 2),
            () => context.router.replaceNamed(SetupPage.routeName),
          );
        }
      },
      builder: (context, state) {
        return LoadingLgButton(
          text: state.showSmsCode ? 'VERIFY' : 'CREATE BUSINESS',
          controller: _buttonController,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              return context.read<RegisterBloc>().add(PhoneFormSubmit());
            }

            _buttonController.error();
            _timer = Timer(
              const Duration(seconds: 3),
              _buttonController.reset,
            );
          },
        );
      },
    );
  }
}

class _EmailRegisterForm extends StatelessWidget {
  const _EmailRegisterForm({required this.formKey, Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BusinessNameInput(),
        const SizedBox(height: 10),
        const _EmailInput(),
        const SizedBox(height: 10),
        const _PasswordInput(),
        const SizedBox(height: 20),
        _EmailRegisterButton(formKey: formKey)
      ],
    );
  }
}

class _BusinessNameInput extends StatelessWidget {
  const _BusinessNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: const FiberInputDecoration(
        labelText: 'Business Name',
        prefixIcon: Icon(
          Icons.store_mall_directory_sharp,
        ),
        helperText: 'Only alphabets, letters, "_" and "-" are allowed.',
      ),
      maxLength: 99,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          wordNumberUnderscoreHyphenSpaceRegex,
        ),
      ],
      validator: (value) {
        String val = value!.trim();
        if (val.isEmpty) return 'Please enter your business name';
        if (val.length < 3) return 'At least 3 characters';
        if (val != StringUtils.wordNumberUnderscoreHyphenSpace(val)) {
          return 'Name contains invalid characters.';
        }
        return null;
      },
      onChanged: (value) {
        context.read<RegisterBloc>().add(BusinessNameChanged(name: value));
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email,
          keyboardType: TextInputType.emailAddress,
          decoration: const FiberInputDecoration(
            labelText: 'Business Email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          validator: (value) {
            String val = value!.trim();
            if (val.isEmpty) return 'Please enter your business email';
            if (!emailRegExp.hasMatch(val)) {
              return 'Please enter a valid email';
            }
            if (val.length > 99) return 'Maximum length (100) exceeded';
            return null;
          },
          onChanged: (value) {
            context.read<RegisterBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: state.hidePassword,
          decoration: FiberInputDecoration(
            labelText: 'Create a Password',
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: state.password.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      state.hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      context
                          .read<RegisterBloc>()
                          .add(TogglePasswordVisibility());
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            context.read<RegisterBloc>().add(PasswordChanged(password: value));
          },
          validator: (value) {
            String val = value!.trim();
            if (val.isEmpty) return 'Please enter your password';
            if (!passwordRegExp.hasMatch(val)) {
              Notify.error(
                context,
                'Password must contain an uppercase letter, a lowercase '
                'letter, a number and at least 8 characters.',
              );
              return 'Invalid format';
            }
            return null;
          },
        );
      },
    );
  }
}

class _EmailRegisterButton extends StatefulWidget {
  const _EmailRegisterButton({required this.formKey, Key? key})
      : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<_EmailRegisterButton> createState() => _EmailRegisterButtonState();
}

class _EmailRegisterButtonState extends State<_EmailRegisterButton> {
  final _buttonController = RoundedLoadingButtonController();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.emailSubmitError) {
          _buttonController.error();
          _timer = Timer(
            const Duration(seconds: 3),
            _buttonController.reset,
          );
        }
        if (state.status == Status.registerSuccess) {
          _buttonController.success();
          _timer = Timer(const Duration(seconds: 1), () {
            infoDialog(
              context: context,
              body: 'Account created successfully. An email has been sent to '
                  'you, tap the link provided to complete registration. After '
                  'verifying, "Login"',
              title: 'SUCCESS',
              then: () => context.router.pushNamed(LoginPage.routeName),
              cancelText: 'Login',
            );
          });
        }
      },
      builder: (context, state) {
        return LoadingLgButton(
          text: 'CREATE BUSINESS',
          controller: _buttonController,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              return context.read<RegisterBloc>().add(EmailFormSubmit());
            }

            _buttonController.error();
            _timer = Timer(
              const Duration(seconds: 3),
              _buttonController.reset,
            );
          },
        );
      },
    );
  }
}

class _RegisterWith extends StatelessWidget {
  const _RegisterWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.read<RegisterBloc>().add(ToggleRegisterForm());
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Text.rich(
                TextSpan(
                  text: 'Register with ',
                  children: <TextSpan>[
                    TextSpan(
                      text: (state.showPhoneRegister
                          ? 'email.'
                          : 'phone number.'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StaffAccount extends StatelessWidget {
  const _StaffAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            infoDialog(
              context: context,
              body: staffAccountInfo,
            );
          },
          child: Text.rich(
            TextSpan(
              text: 'Staff? ',
              children: <TextSpan>[
                TextSpan(
                  text: 'Create Staff Account.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By creating an account you agree to our ',
        children: <TextSpan>[
          LinkTextSpan(
            text: 'Privacy policy',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            url: privacyPolicyLink,
          ),
          const TextSpan(text: ' and '),
          LinkTextSpan(
            text: 'terms of use.',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            url: termsOfUseLink,
          ),
        ],
      ),
    );
  }
}
