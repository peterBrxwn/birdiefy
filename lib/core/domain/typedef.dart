import 'package:birdiefy/core/domain/entity/app_error.dart';
import 'package:dartz/dartz.dart';

typedef ErrorOrType<T> = Either<AppError, T>;
