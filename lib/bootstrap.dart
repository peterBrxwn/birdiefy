import 'dart:async';
import 'dart:developer';

import 'package:birdiefy/bloc_observer.dart';
import 'package:birdiefy/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError =
      ((e) => log(e.exceptionAsString(), stackTrace: e.stack));
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  Bloc.observer = AppBlocObserver();
  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
