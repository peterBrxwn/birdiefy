// Package imports:
import 'dart:convert';

import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/domain/entity/user_type.dart';
import 'package:birdiefy/utils/time_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class UserModel extends User {
  const UserModel({
    required DateTime dateAdded,
    required String email,
    required String firstname,
    required String handicap,
    required String lastname,
    required UserType userType,
    String? id,
  }) : super(
          dateAdded: dateAdded,
          email: email,
          firstname: firstname,
          handicap: handicap,
          id: id,
          lastname: lastname,
          userType: userType,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromJsonString(String json) =>
      _$UserModelFromJson(jsonDecode(json));
  String toJsonString() => jsonEncode(_$UserModelToJson(this));

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    _,
  ) {
    final json = snapshot.data()!;
    json['id'] = snapshot.id;
    json['date_added'] =
        TimeUtils.toDateTime(json['date_added'] as Timestamp).toIso8601String();
    return _$UserModelFromJson(json);
  }
  Map<String, dynamic> toFirestore() {
    final json = _$UserModelToJson(this);
    json['date_added'] = TimeUtils.fromDateTime(
      DateTime.parse(json['date_added'] as String),
    );
    return json;
  }

  factory UserModel.fromEntity(User user) => UserModel(
        dateAdded: user.dateAdded,
        email: user.email,
        firstname: user.firstname,
        handicap: user.handicap,
        id: user.id,
        lastname: user.lastname,
        userType: user.userType,
      );
}
