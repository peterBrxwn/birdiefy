import 'package:dartz/dartz.dart';
import 'package:fiber/core/domain/entity/fiber_error.dart';

typedef ErrorOrType<T> = Either<FiberError, T>;
