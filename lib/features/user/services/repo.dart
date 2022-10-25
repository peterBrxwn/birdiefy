import 'package:birdiefy/core/domain/entity/app_error.dart';
import 'package:birdiefy/core/domain/typedef.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/domain/repo.dart';
import 'package:birdiefy/features/user/services/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserImpl implements UserRepo {
  static CollectionReference<UserModel> _collection() =>
      FirebaseFirestore.instance.collection('user').withConverter<UserModel>(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (data, _) => data.toFirestore(),
          );
  static DocumentReference<UserModel> _reference(String? id) =>
      _collection().doc(id);

  @override
  ErrorOrType<String> add(User user) {
    try {
      _reference(user.id!).set(UserModel.fromEntity(user));
      return Right(user.id!);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  static Future<User?> auth({
    required String id,
  }) async {
    final doc = await _reference(id).get();
    return doc.data();
  }

  static Future<ErrorOrType<Unit>> authRegister({required User user}) async {
    try {
      await _reference(user.id!).set(UserModel.fromEntity(user));
      return const Right(unit);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  @override
  ErrorOrType<Unit> update(User user) {
    try {
      _reference(user.id).update(UserModel.fromEntity(user).toJson());
      return const Right(unit);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  @override
  ErrorOrType<Unit> delete(String id) {
    try {
      _reference(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  @override
  Stream<ErrorOrType<UserModel?>> stream({required String id}) async* {
    yield* _reference(id).snapshots().map((element) {
      try {
        return Right(element.data());
      } catch (e) {
        return Left(AppError(debugError: e.toString()));
      }
    });
  }
}
