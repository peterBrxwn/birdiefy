import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/core/domain/constants.dart';
import 'package:birdiefy/features/login/view/view.dart';
import 'package:birdiefy/features/notifications/view/view.dart';
import 'package:birdiefy/features/tab/view/view.dart';
import 'package:birdiefy/features/user/domain/entity/user_type.dart';
import 'package:birdiefy/shared/input_decoration.dart';
import 'package:birdiefy/shared/buttons/loading_button.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/features/register/bloc/register_bloc.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatelessWidget implements AutoRouteWrapper {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = 'register';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => RegisterBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => current.notifMsg != null,
      listener: (context, state) {
        Notify.generic(
          context,
          state.notifMsg!.type,
          state.notifMsg!.message,
        );
      },
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
        backgroundColor: AppTheme.background,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const _Form(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Have an account already?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.router.pushNamed(LoginPage.routeName),
                    child: Text(
                      'Login here',
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
              const SizedBox(height: 10),
              Text(
                'Confirm password',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _ConfirmPasswordInput(),
              const SizedBox(height: 10),
              Text(
                'First name',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _FirstNameInput(),
              const SizedBox(height: 10),
              Text(
                'Last name',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _LastNameInput(),
              const SizedBox(height: 10),
              Text(
                'Handicap',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _HandicapInput(),
              const SizedBox(height: 10),
              Text(
                'You are a:',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _UserTypeInput(),
              const SizedBox(height: 10),
              _SubmitButton(formKey: _formKey)
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: AppTheme.themeGreen),
          keyboardType: TextInputType.emailAddress,
          decoration: AppInputDecoration(
            labelText: 'Enter your email here...',
          ),
          validator: (value) {
            String val = value!.trim();
            if (val.isEmpty) return 'Please enter your email';
            if (!Constants.emailRegExp.hasMatch(val)) {
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
          style: const TextStyle(color: AppTheme.themeGreen),
          decoration: AppInputDecoration(
            labelText: 'Enter your password here...',
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
            if (val.length < 6) {
              return 'Password must contain at least 6 password';
            }
            return null;
          },
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: state.hideConfirmPassword,
          style: const TextStyle(color: AppTheme.themeGreen),
          decoration: AppInputDecoration(
            labelText: 'Confirm password here...',
            suffixIcon: state.confirmPassword.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      state.hideConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      context
                          .read<RegisterBloc>()
                          .add(ToggleConfirmPasswordVisibility());
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(ConfirmPasswordChanged(password: value));
          },
          validator: (value) {
            String val = value!.trim();
            if (val.isEmpty) return 'Please enter your password';
            if (val.length < 6) {
              return 'Password must contain at least 6 password';
            }
            return null;
          },
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: const TextStyle(color: AppTheme.themeGreen),
      textCapitalization: TextCapitalization.words,
      decoration: AppInputDecoration(labelText: 'Enter your name here...'),
      validator: (value) {
        String val = value!.trim();
        if (val.isEmpty) return 'Please enter your first name';
        if (val.length < 3) return 'At least 3 characters';
        return null;
      },
      onChanged: (value) {
        context.read<RegisterBloc>().add(FirstNameChanged(name: value));
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  const _LastNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: const TextStyle(color: AppTheme.themeGreen),
      textCapitalization: TextCapitalization.words,
      decoration: AppInputDecoration(labelText: 'Enter your last name here...'),
      validator: (value) {
        String val = value!.trim();
        if (val.isEmpty) return 'Please enter your last name';
        if (val.length < 3) return 'At least 3 characters';
        return null;
      },
      onChanged: (value) {
        context.read<RegisterBloc>().add(LastNameChanged(name: value));
      },
    );
  }
}

class _HandicapInput extends StatelessWidget {
  const _HandicapInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: const TextStyle(color: AppTheme.themeGreen),
      textCapitalization: TextCapitalization.words,
      decoration: AppInputDecoration(labelText: 'Ex. 12'),
      validator: (value) {
        String val = value!.trim();
        if (val.isEmpty) return 'Please enter handicap';
        return null;
      },
      onChanged: (value) {
        context.read<RegisterBloc>().add(HandicapChanged(value: value));
      },
    );
  }
}

class _UserTypeInput extends StatelessWidget {
  const _UserTypeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<RegisterBloc>()
                        .add(const UserTypeChanged(type: UserType.player));
                  },
                  child: Text(
                    'Player',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: state.userType == UserType.player
                              ? AppTheme.themeGreen
                              : AppTheme.white,
                        ),
                  ),
                ),
                Radio<UserType>(
                  value: UserType.player,
                  groupValue: state.userType,
                  onChanged: (value) {
                    context
                        .read<RegisterBloc>()
                        .add(UserTypeChanged(type: value!));
                  },
                  activeColor: AppTheme.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return state.userType == UserType.player
                          ? AppTheme.themeGreen
                          : AppTheme.white;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    context
                        .read<RegisterBloc>()
                        .add(const UserTypeChanged(type: UserType.coach));
                  },
                  child: Text(
                    'Coach',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: state.userType == UserType.coach
                              ? AppTheme.themeGreen
                              : AppTheme.white,
                        ),
                  ),
                ),
                Radio<UserType>(
                  value: UserType.coach,
                  groupValue: state.userType,
                  onChanged: (value) {
                    context
                        .read<RegisterBloc>()
                        .add(UserTypeChanged(type: value!));
                  },
                  activeColor: AppTheme.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return state.userType == UserType.coach
                          ? AppTheme.themeGreen
                          : AppTheme.white;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
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
    return BlocConsumer<RegisterBloc, RegisterState>(
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
          text: 'Create Account',
          controller: _buttonController,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              return context.read<RegisterBloc>().add(Register());
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
