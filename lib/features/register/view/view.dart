import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/notifications/view/view.dart';
import 'package:birdiefy/core/services/constants.dart';
import 'package:birdiefy/features/user/domain/entity/user_type.dart';
import 'package:birdiefy/shared/input_decoration.dart';
import 'package:birdiefy/shared/buttons/loading_lg_button.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/features/register/bloc/register_bloc.dart';
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
                  children: const [
                    SizedBox(height: 20),
                    _Form(),
                    SizedBox(height: 40),
                    Text('Have an account already?'),
                    Text('Login here'),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _EmailInput(),
              const SizedBox(height: 10),
              const _PasswordInput(),
              const SizedBox(height: 10),
              const _ConfirmPasswordInput(),
              const SizedBox(height: 10),
              const _FirstNameInput(),
              const SizedBox(height: 10),
              const _LastNameInput(),
              const SizedBox(height: 20),
              const _HandicapInput(),
              const SizedBox(height: 20),
              const _UserTypeInput(),
              const SizedBox(height: 20),
              _EmailRegisterButton(formKey: _formKey)
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
          obscureText: state.hidePassword,
          decoration: FiberInputDecoration(
            labelText: 'Confirm Password',
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
      textCapitalization: TextCapitalization.words,
      decoration: const FiberInputDecoration(
        labelText: 'First Name',
        prefixIcon: Icon(
          Icons.store_mall_directory_sharp,
        ),
        helperText: 'Only alphabets, letters, "_" and "-" are allowed.',
      ),
      maxLength: 99,
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
      textCapitalization: TextCapitalization.words,
      decoration: const FiberInputDecoration(
        labelText: 'Last Name',
        prefixIcon: Icon(
          Icons.store_mall_directory_sharp,
        ),
        helperText: 'Only alphabets, letters, "_" and "-" are allowed.',
      ),
      maxLength: 99,
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
      textCapitalization: TextCapitalization.words,
      decoration: const FiberInputDecoration(
        labelText: 'Ex. 12',
        prefixIcon: Icon(
          Icons.store_mall_directory_sharp,
        ),
      ),
      maxLength: 99,
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
      children: [
        const Text('You are a:'),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Row(
              children: [
                const Text('Player'),
                Radio<UserType>(
                  value: UserType.player,
                  groupValue: state.userType,
                  onChanged: (value) {
                    context
                        .read<RegisterBloc>()
                        .add(UserTypeChanged(type: value!));
                  },
                ),
                const SizedBox(width: 10),
                const Text('Coach'),
                Radio<UserType>(
                  value: UserType.coach,
                  groupValue: state.userType,
                  onChanged: (value) {
                    context
                        .read<RegisterBloc>()
                        .add(UserTypeChanged(type: value!));
                  },
                ),
              ],
            );
          },
        ),
      ],
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
              context.router.pushNamed('tab');
            },
          );
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
