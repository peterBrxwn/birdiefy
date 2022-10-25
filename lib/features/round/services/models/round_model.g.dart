// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoundModel _$RoundModelFromJson(Map<String, dynamic> json) => RoundModel(
      course: json['course'] as String,
      date: DateTime.parse(json['date'] as String),
      dateAdded: DateTime.parse(json['date_added'] as String),
      numberOfHoles: json['number_of_holes'] as int,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$RoundModelToJson(RoundModel instance) {
  final val = <String, dynamic>{
    'course': instance.course,
    'date': instance.date.toIso8601String(),
    'date_added': instance.dateAdded.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['number_of_holes'] = instance.numberOfHoles;
  return val;
}
