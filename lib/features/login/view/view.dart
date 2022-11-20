// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// Project imports:
import 'package:birdiefy/core/constants.dart';
import 'package:birdiefy/features/login/bloc/login_bloc.dart';
import 'package:birdiefy/features/notifications/view/view.dart';
import 'package:birdiefy/features/register/view/view.dart';
import 'package:birdiefy/features/tab/view/view.dart';
import 'package:birdiefy/shared/buttons/loading_button.dart';
import 'package:birdiefy/shared/input_decoration.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/utils/app_theme.dart';

class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = 'login';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => LoginBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current.notifMsg != null,
      listener: (context, state) {
        Notify.generic(
          context,
          state.notifMsg!.type,
          state.notifMsg!.message,
        );
      },
      child: _View(),
    );
  }
}

class _View extends StatelessWidget {
  _View({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RemoveFocus(
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: _Form(formKey: _formKey),
                        ),
                        const SizedBox(height: 20),
                        _SubmitButton(formKey: _formKey),
                      ],
                    ),
                  ),
                  Text(
                    'Don\'t have an account yet?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.router.pushNamed(RegisterPage.routeName),
                    child: Text(
                      'Register here',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.formKey, Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Email',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _EmailInput(),
              const SizedBox(height: 10),
              Text(
                'Password',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _PasswordInput(),
            ],
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: AppTheme.themeGreen),
          keyboardType: TextInputType.emailAddress,
          decoration: AppInputDecoration(
            labelText: 'Enter your Email here...',
            prefixIcon: Icons.email_outlined,
          ),
          validator: (value) {
            final val = value!.trim();
            if (val.isEmpty) return 'Please enter your email';
            if (!Constants.emailRegExp.hasMatch(val)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: state.hidePassword,
          style: const TextStyle(color: AppTheme.themeGreen),
          decoration: AppInputDecoration(
            labelText: 'Enter your password here...',
            prefixIcon: Icons.lock_outlined,
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
                          .read<LoginBloc>()
                          .add(const TogglePasswordVisibility());
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          validator: (value) {
            final val = value!.trim();
            if (val.isEmpty) return 'Please enter your password';
            return null;
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.formKey, Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  final _buttonController = RoundedLoadingButtonController();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.submitError) {
          _buttonController.error();
          _timer = Timer(
            const Duration(seconds: 3),
            _buttonController.reset,
          );
        }
        if (state.status == Status.submitSuccess) {
          _buttonController.success();
          _timer = Timer(
            const Duration(seconds: 2),
            () {
              context.router.removeUntil((_) => false);
              context.router.pushNamed(TabPage.routeName);
            },
          );
        }
      },
      builder: (context, state) {
        return LoadingButton(
          text: 'Login',
          controller: _buttonController,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              return context.read<LoginBloc>().add(const Login());
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
