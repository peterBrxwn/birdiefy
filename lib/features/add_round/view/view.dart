import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/add_round/bloc/add_round_bloc.dart';
import 'package:birdiefy/features/notifications/view/view.dart';
import 'package:birdiefy/features/round/services/repo.dart';
import 'package:birdiefy/features/tab/view/view.dart';
import 'package:birdiefy/shared/buttons/loading_button.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:birdiefy/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddRoundPage extends StatelessWidget implements AutoRouteWrapper {
  const AddRoundPage({Key? key}) : super(key: key);

  static const routeName = 'add_round';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRoundBloc(roundRepo: context.read<RoundImpl>()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddRoundBloc, AddRoundState>(
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

class _View extends StatefulWidget {
  const _View({Key? key}) : super(key: key);

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    final height = MediaQuery.of(context).size.height;
    context.read<AddRoundBloc>().add(ScreenHeightChanged(height: height));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RemoveFocus(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Round',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AppTheme.white),
          ),
          backgroundColor: AppTheme.themeGreen,
        ),
        backgroundColor: AppTheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                child: _Form(formKey: _formKey),
              ),
              const SizedBox(height: 20),
              _SubmitButton(formKey: _formKey),
            ],
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
    return BlocBuilder<AddRoundBloc, AddRoundState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Date of the round',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _DateInput(),
              const SizedBox(height: 10),
              Text(
                'Select the course',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _CourseInput(),
              const SizedBox(height: 10),
              Text(
                'Number of holes',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              const _NoOfHolesInput(),
            ],
          ),
        );
      },
    );
  }
}

class _DateInput extends StatelessWidget {
  const _DateInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRoundBloc, AddRoundState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final bloc = context.read<AddRoundBloc>();
            final date = await showDatePicker(
              context: context,
              currentDate: state.date,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000, 8),
              lastDate: DateTime(2100),
            );
            if (date != null) bloc.add(DateChanged(date: date));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.themeGreen),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              state.date != null
                  ? TimeUtils.shortDateFormat(state.date!)
                  : 'Select the date',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.lightGrey),
            ),
          ),
        );
      },
    );
  }
}

class _CourseInput extends StatelessWidget {
  const _CourseInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRoundBloc, AddRoundState>(
      builder: (context, state) {
        return DropdownSearch<String>(
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              labelText: 'Select the place',
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.lightGrey),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          popupProps: PopupProps.menu(
            menuProps: const MenuProps(),
            constraints: BoxConstraints(
              maxHeight: state.coursesDropdownParams.maxHeight,
            ),
            showSelectedItems: true,
          ),
          items: state.courses,
          validator: (value) {
            final val = value?.trim();
            if (val == null || val.isEmpty) {
              return 'Please select the place';
            }
            return null;
          },
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? 'Please select the place',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.lightGrey),
            );
          },
          onChanged: (value) {
            context.read<AddRoundBloc>().add(CourseChanged(course: value!));
          },
          selectedItem: state.course,
        );
      },
    );
  }
}

class _NoOfHolesInput extends StatelessWidget {
  const _NoOfHolesInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRoundBloc, AddRoundState>(
      builder: (context, state) {
        return DropdownSearch<String>(
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              labelText: '9 or 18 holes round',
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.lightGrey),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          popupProps: const PopupProps.menu(
            showSelectedItems: true,
            constraints: BoxConstraints(
              maxHeight: 55 * 2,
            ),
          ),
          items: const ['9 holes', '18 holes'],
          onChanged: (value) {
            final numberOfHoles = value == '9 holes' ? 9 : 18;
            context
                .read<AddRoundBloc>()
                .add(NumberOfHolesChanged(numberOfHoles: numberOfHoles));
          },
          validator: (value) {
            final val = value?.trim();
            if (val == null || val.isEmpty) {
              return 'Please enter number of holes';
            }
            return null;
          },
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? '9 or 18 holes round',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.lightGrey),
            );
          },
          selectedItem: state.numberOfHoles == null
              ? null
              : '${state.numberOfHoles} holes',
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
    return BlocConsumer<AddRoundBloc, AddRoundState>(
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
          text: 'Add Round',
          controller: _buttonController,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              return context.read<AddRoundBloc>().add(const Submit());
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
