import 'package:birdiefy/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// True if any element satisfies [test], or false if none.
  bool firstWhereBool(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return true;
    }
    return false;
  }
}

extension ParseNumbers on String {
  /// Converts camelCase to Sentence case
  String get camelToSentenceCase {
    String result = replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m[0]}');
    return result[0].toUpperCase() + result.substring(1).toLowerCase();
  }

  String get capitalize {
    if (this == '') return '';
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get toTitleCase {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.capitalize)
        .join(' ');
  }

  /// Returns if the string is a valid double.
  bool get validateDouble {
    if (isEmpty) return true;
    return double.tryParse(replaceAll(',', '')) != null;
  }

  /// Returns if the string is a valid double.
  double get validDouble {
    if (isEmpty) return 0;
    return double.parse(replaceAll(',', ''));
  }

  /// Returns if the string is a valid double.
  bool get validateInt {
    if (isEmpty) return true;
    return int.tryParse(replaceAll(',', '')) != null;
  }

  /// Returns if the string is a valid double.
  int get validInt {
    if (isEmpty) return 0;
    return int.parse(replaceAll(',', ''));
  }

  /// Returns if the string is a valid double.
  bool get validateDate {
    return DateTime.tryParse(TimeUtils.reverseDateInputFormat(this)) != null;
  }

  /// Returns if the string is a valid double.
  DateTime get validDate =>
      DateTime.parse(TimeUtils.reverseDateInputFormat(this));
}

extension DoubleX on double {
  /// Returns the double as a currency.
  String toCurrency(String currency) {
    if (this == 0) return '$currency 0.00';
    if (currency.isNotEmpty) currency += ' ';
    return NumberFormat.currency(symbol: currency).format(this);
  }

  /// Returns the double in compact currency format.
  String toCompactCurrency(String currency) {
    if (this == 0) return '$currency 0';
    return '$currency ${NumberFormat.compact().format(this)}';
  }

  /// Returns the double in 2dp
  double get to2DP => num.parse(toStringAsFixed(2)) as double;

  /// Returns the double in thousands format.
  String get toThousand {
    if (this == 0) return '0';
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]!},',
    );
  }
}

extension IntX on int {
  /// Returns the int in thousands format.
  String get toThousand {
    if (this == 0) return '0';
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]!},',
    );
  }
}

extension DateTimeX on DateTime? {
  /// Returns the int in thousands format.
  String get toInputString {
    if (this == null) return '';
    final dateString = toString();

    if (!dateString.contains('-')) return dateString.substring(0, 10);
    return '${dateString.substring(8, 10)}/${dateString.substring(5, 7)}/${dateString.substring(0, 4)}';
  }
}

extension EnumX on Enum {
  String get name {
    String result = name.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => ' ${m[0]}',
    );
    return result[0].toUpperCase() + result.substring(1).toLowerCase();
  }
}

extension CustomContext on BuildContext {
  /// Check whether it is dark mode.
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}
