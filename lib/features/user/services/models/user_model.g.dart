// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      dateAdded: DateTime.parse(json['date_added'] as String),
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      handicap: json['handicap'] as String,
      id: json['id'] as String,
      lastname: json['lastname'] as String,
      userType: $enumDecode(_$UserTypeEnumMap, json['user_type']),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'date_added': instance.dateAdded.toIso8601String(),
      'email': instance.email,
      'firstname': instance.firstname,
      'handicap': instance.handicap,
      'id': instance.id,
      'lastname': instance.lastname,
      'user_type': _$UserTypeEnumMap[instance.userType]!,
    };

const _$UserTypeEnumMap = {
  UserType.coach: 'coach',
  UserType.player: 'player',
};
