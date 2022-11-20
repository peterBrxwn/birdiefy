// Package imports:
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:birdiefy/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await $initGetIt(locator);
