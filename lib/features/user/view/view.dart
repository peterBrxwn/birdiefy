import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/core/domain/constants.dart';
import 'package:birdiefy/core/domain/entity/enums.dart';
import 'package:birdiefy/features/login/view/view.dart';
import 'package:birdiefy/features/user/bloc/user_bloc.dart';
import 'package:birdiefy/features/user/services/repo.dart';
import 'package:birdiefy/shared/buttons/icon_button.dart';
import 'package:birdiefy/shared/loading.dart';
import 'package:birdiefy/shared/message.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget implements AutoRouteWrapper {
  const UserPage({Key? key}) : super(key: key);

  static const routeName = 'round';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          UserBloc(userRepo: context.read<UserImpl>())..add(const Init()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const _View();
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RemoveFocus(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              String name = 'User';
              if (state.user != null) {
                name = '${state.user!.firstname} ${state.user!.lastname[0]}';
              }

              return Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: AppTheme.white),
              );
            },
          ),
          actions: [
            ThemeIconButton(
              icon: Icons.logout_outlined,
              color: ButtonColorEnum.white,
              onPressed: () {
                context.read<UserBloc>().add(const Logout());
                context.router.removeUntil((route) => false);
                context.router.pushNamed(LoginPage.routeName);
              },
            ),
          ],
          backgroundColor: AppTheme.themeGreen,
        ),
        backgroundColor: AppTheme.background,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state.status == Status.loading) return const Loading();
                  if (state.status == Status.error) return const Message();
                  if (state.user == null) return const Loading();

                  return Column(
                    children: const [
                      _Header(),
                      SizedBox(height: 20),
                      _Details(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 240,
          margin: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
            color: AppTheme.black,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('${Constants.assetsPath}profile.jpg'),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'HANDICAP',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppTheme.white),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Text(
                      state.user!.handicap,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: AppTheme.white),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stats',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: AppTheme.white),
          ),
          const SizedBox(height: 10),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Text(
                    'Birdies',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(
                      value: 0.3,
                      minHeight: 15,
                      backgroundColor: AppTheme.background,
                    ),
                  ),
                  Text(
                    '55%',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Birdies',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(
                      value: 0.3,
                      minHeight: 15,
                      backgroundColor: AppTheme.background,
                    ),
                  ),
                  Text(
                    '55%',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Birdies',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(
                      value: 0.3,
                      minHeight: 15,
                      backgroundColor: AppTheme.background,
                    ),
                  ),
                  Text(
                    '55%',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Birdies',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(
                      value: 0.3,
                      minHeight: 15,
                      backgroundColor: AppTheme.background,
                    ),
                  ),
                  Text(
                    '55%',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
