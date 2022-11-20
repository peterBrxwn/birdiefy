// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:birdiefy/core/domain/entity/app_error.dart';

typedef ErrorOrType<T> = Either<AppError, T>;
