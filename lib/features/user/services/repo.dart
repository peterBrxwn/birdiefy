import 'package:birdiefy/core/domain/entity/app_error.dart';
import 'package:birdiefy/core/domain/typedef.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/domain/repo.dart';
import 'package:birdiefy/features/user/services/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserImpl implements UserRepo {
  static CollectionReference<UserModel> _collection([String? companyId]) =>
      FirebaseFirestore.instance.collection('user').withConverter<UserModel>(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (data, _) => data.toFirestore(),
          );
  Query<UserModel> _query() => _collection().orderBy('name');

  Stream<QuerySnapshot<UserModel>> _snapshots() => _query().snapshots();
  static DocumentReference<UserModel> _reference(String? id,
          [String? companyId]) =>
      _collection(companyId).doc(id);
  String _getDocId() => _collection().doc().id;

  @override
  ErrorOrType<String> add(User user) {
    try {
      final docId = user.id ?? _getDocId();
      _reference(docId).set(UserModel.fromEntity(user));
      return Right(docId);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  static Future<User?> auth({
    required String id,
    required String companyId,
  }) async {
    final doc = await _reference(id, companyId).get();
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
  Stream<ErrorOrType<List<User>>> stream() async* {
    yield* _snapshots().map((element) {
      try {
        return Right(element.docs.map((e) => e.data()).toList());
      } catch (e) {
        return Left(AppError(debugError: e.toString()));
      }
    });
  }
}
