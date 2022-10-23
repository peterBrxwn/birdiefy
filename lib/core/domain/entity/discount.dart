import 'package:equatable/equatable.dart';
import 'package:fiber/core/domain/ext.dart';

class Discount extends Equatable {
  final double naira;
  final double percent;
  final bool showCurrency;

  String toCurrency(String currency) {
    String str = naira.toCurrency(currency);
    if (showCurrency) return str;
    return str + ' ($percent%)';
  }

  const Discount({
    this.naira = 0,
    this.percent = 0,
    this.showCurrency = true,
  });

  Discount copyWith({double? naira, double? percent, bool? showCurrency}) {
    return Discount(
      naira: naira ?? this.naira,
      percent: percent ?? this.percent,
      showCurrency: showCurrency ?? this.showCurrency,
    );
  }

  @override
  List<Object?> get props => [naira, percent, showCurrency];
}
