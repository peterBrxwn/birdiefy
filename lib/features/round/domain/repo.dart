import 'package:birdiefy/core/domain/typedef.dart';
import 'package:birdiefy/features/round/domain/entity/round_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RoundRepo {
  ErrorOrType<String> add({required Round round, required String userId});
  ErrorOrType<Unit> delete({required String id, required String userId});
  Stream<ErrorOrType<List<Round>>> stream({required String userId});
  ErrorOrType<Unit> update({required Round round, required String userId});
}
