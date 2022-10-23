// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountModel _$DiscountModelFromJson(Map<String, dynamic> json) =>
    DiscountModel(
      naira: (json['naira'] as num).toDouble(),
      percent: (json['percent'] as num).toDouble(),
      showCurrency: json['show_currency'] as bool,
    );

Map<String, dynamic> _$DiscountModelToJson(DiscountModel instance) =>
    <String, dynamic>{
      'naira': instance.naira,
      'percent': instance.percent,
      'show_currency': instance.showCurrency,
    };
