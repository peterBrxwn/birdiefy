// Package imports:
import 'dart:convert';

import 'package:birdiefy/features/round/domain/entity/round_entity.dart';
import 'package:birdiefy/utils/time_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'round_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class RoundModel extends Round {
  const RoundModel({
    required String course,
    required DateTime date,
    required DateTime dateAdded,
    required int numberOfHoles,
    String? id,
  }) : super(
          course: course,
          date: date,
          dateAdded: dateAdded,
          id: id,
          numberOfHoles: numberOfHoles,
        );

  factory RoundModel.fromJson(Map<String, dynamic> json) =>
      _$RoundModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoundModelToJson(this);
  factory RoundModel.fromJsonString(String json) =>
      _$RoundModelFromJson(jsonDecode(json));
  String toJsonString() => jsonEncode(_$RoundModelToJson(this));

  factory RoundModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    _,
  ) {
    final json = snapshot.data()!;
    json['id'] = snapshot.id;
    json[dateJson] = TimeUtils.toDateTime(json[dateJson] as Timestamp)
        .toIso8601String();
    json[dateAddedJson] = TimeUtils.toDateTime(json[dateAddedJson] as Timestamp)
        .toIso8601String();
    return _$RoundModelFromJson(json);
  }
  Map<String, dynamic> toFirestore() {
    final json = _$RoundModelToJson(this);
    json[dateJson] = TimeUtils.fromDateTime(
      DateTime.parse(json[dateJson] as String),
    );
    json[dateAddedJson] = TimeUtils.fromDateTime(
      DateTime.parse(json[dateAddedJson] as String),
    );
    return json;
  }

  factory RoundModel.fromEntity(Round round) => RoundModel(
        course: round.course,
        date: round.date,
        dateAdded: round.dateAdded,
        id: round.id,
        numberOfHoles: round.numberOfHoles,
      );

  static String dateJson = 'date';
  static String dateAddedJson = 'date_added';
}
