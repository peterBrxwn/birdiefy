import 'package:birdiefy/core/domain/entity/app_error.dart';
import 'package:birdiefy/core/domain/typedef.dart';
import 'package:birdiefy/features/round/domain/entity/round_entity.dart';
import 'package:birdiefy/features/round/domain/repo.dart';
import 'package:birdiefy/features/round/services/models/round_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class RoundImpl implements RoundRepo {
  static CollectionReference<RoundModel> _collection(String userId) =>
      FirebaseFirestore.instance
          .collection('user/$userId/round')
          .withConverter<RoundModel>(
            fromFirestore: RoundModel.fromFirestore,
            toFirestore: (data, _) => data.toFirestore(),
          );
  Query<RoundModel> _query(String userId) =>
      _collection(userId).orderBy(RoundModel.dateJson, descending: true);

  Stream<QuerySnapshot<RoundModel>> _snapshots(userId) =>
      _query(userId).snapshots();
  static DocumentReference<RoundModel> _reference({required String id, required String userId}) =>
      _collection(userId).doc(id);
  String _getDocId(userId) => _collection(userId).doc().id;

  @override
  ErrorOrType<String> add({required Round round, required String userId}) {
    try {
      final docId = _getDocId(userId);
      _reference(id: docId, userId: userId).set(RoundModel.fromEntity(round));
      return Right(docId);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  @override
  ErrorOrType<Unit> update({required Round round, required String userId}) {
    try {
      _reference(id: round.id!, userId: userId).update(RoundModel.fromEntity(round).toJson());
      return const Right(unit);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  @override
  ErrorOrType<Unit> delete({required String id, required String userId}) {
    try {
      _reference(id: id, userId: userId).delete();
      return const Right(unit);
    } catch (e) {
      return Left(AppError(debugError: e.toString()));
    }
  }

  @override
  Stream<ErrorOrType<List<Round>>> stream({required String userId}) async* {
    yield* _snapshots(userId).map((element) {
      try {
        return Right(element.docs.map((e) => e.data()).toList());
      } catch (e) {
        return Left(AppError(debugError: e.toString()));
      }
    });
  }
}
