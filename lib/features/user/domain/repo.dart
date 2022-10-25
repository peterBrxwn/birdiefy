import 'package:birdiefy/core/domain/typedef.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/services/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  ErrorOrType<String> add(User user);
  ErrorOrType<Unit> delete(String id);
  Stream<ErrorOrType<UserModel?>> stream({required String id});
  ErrorOrType<Unit> update(User user);
}
