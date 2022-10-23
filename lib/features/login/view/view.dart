import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/notifications/view/view.dart';
import 'package:birdiefy/core/services/constants.dart';
import 'package:birdiefy/shared/input_decoration.dart';
import 'package:birdiefy/shared/buttons/loading_lg_button.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = 'login';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => LoginBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
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
                  children: const [
                    SizedBox(height: 40),
                    _Form(),
                    SizedBox(height: 40),
                    Text('Don\'t have an account yet?'),
                    Text('Register here'),
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

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _EmailInput(),
              const SizedBox(height: 10),
              const _PasswordInput(),
              const SizedBox(height: 20),
              _EmailLoginButton(formKey: _formKey)
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
          initialValue: state.email,
          keyboardType: TextInputType.emailAddress,
          decoration: const FiberInputDecoration(
            labelText: 'Enter your Email here...',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          validator: (value) {
            String val = value!.trim();
            if (val.isEmpty) return 'Please enter your email';
            if (!emailRegExp.hasMatch(val)) {
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
          decoration: FiberInputDecoration(
            labelText: 'Enter your password here...',
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
                      context.read<LoginBloc>().add(TogglePasswordVisibility());
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          validator: (value) {
            String val = value!.trim();
            if (val.isEmpty) return 'Please enter your password';
            return null;
          },
        );
      },
    );
  }
}

class _EmailLoginButton extends StatefulWidget {
  const _EmailLoginButton({required this.formKey, Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<_EmailLoginButton> createState() => _EmailLoginButtonState();
}

class _EmailLoginButtonState extends State<_EmailLoginButton> {
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
        if (state.status == Status.emailSubmitError) {
          _buttonController.error();
          _timer = Timer(
            const Duration(seconds: 3),
            _buttonController.reset,
          );
        }
        if (state.status == Status.loginSuccess) {
          _buttonController.success();
          _timer = Timer(
            const Duration(seconds: 2),
            () {
              context.router.removeUntil((_) => false);
              context.router.pushNamed('tab');
            },
          );
        }
      },
      builder: (context, state) {
        return LoadingLgButton(
          text: 'Login',
          controller: _buttonController,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              return context.read<LoginBloc>().add(EmailFormSubmit());
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
