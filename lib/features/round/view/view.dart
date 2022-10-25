import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/features/add_round/view/view.dart';
import 'package:birdiefy/features/round/bloc/round_bloc.dart';
import 'package:birdiefy/features/round/domain/entity/round_entity.dart';
import 'package:birdiefy/features/round/services/repo.dart';
import 'package:birdiefy/shared/message.dart';
import 'package:birdiefy/shared/remove_focus.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:birdiefy/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundPage extends StatelessWidget implements AutoRouteWrapper {
  const RoundPage({Key? key}) : super(key: key);

  static const routeName = 'round';
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RoundBloc(roundRepo: context.read<RoundImpl>())..add(const Init()),
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
          title: Text(
            'My Rounds',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AppTheme.white),
          ),
          backgroundColor: AppTheme.themeGreen,
        ),
        backgroundColor: AppTheme.background,
        floatingActionButton: const _FloatingActionButton(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: BlocBuilder<RoundBloc, RoundState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.rounds.isNotEmpty)
                      Text(
                        'Rounds posted',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 20),
                      for (final round in state.rounds)
                        _RoundDetails(round: round),
                      if (state.rounds.isEmpty)
                        const Message(message: 'No rounds added yet.'),
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

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => context.router.pushNamed(AddRoundPage.routeName),
      elevation: 5,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: AppTheme.black),
    );
  }
}

class _RoundDetails extends StatelessWidget {
  const _RoundDetails({required this.round, Key? key}) : super(key: key);
  final Round round;

  @override
  Widget build(BuildContext context) {
    final suffix = round.numberOfHoles > 1 ? 's' : '';
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(round.course, style: Theme.of(context).textTheme.bodyText1),
              Text(
                TimeUtils.shortDateString(round.dateAdded),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppTheme.white),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '75',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppTheme.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '+3',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                  Text(
                    '${round.numberOfHoles} hole$suffix',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppTheme.white),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.equalizer, color: AppTheme.themeGreen),
              Text('Stats', style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ],
      ),
    );
  }
}
