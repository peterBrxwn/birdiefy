// Package imports:
import 'package:fiber/core/domain/entity/discount.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DiscountModel extends Discount {
  const DiscountModel({
    required double naira,
    required double percent,
    required bool showCurrency,
  }) : super(naira: naira, percent: percent, showCurrency: showCurrency);

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountModelToJson(this);

  factory DiscountModel.fromEntity(Discount discount) => DiscountModel(
        naira: discount.naira,
        percent: discount.percent,
        showCurrency: discount.showCurrency,
      );
}
