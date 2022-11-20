// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:birdiefy/core/typedef.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/services/models/user_model.dart';

abstract class UserRepo {
  ErrorOrType<String> add(User user);
  ErrorOrType<Unit> delete(String id);
  Stream<ErrorOrType<UserModel?>> stream({required String id});
  ErrorOrType<Unit> update(User user);
}
