// Flutter imports:
import 'package:fiber/core/services/constants.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:

// double? validateDouble(String value, {double? ifNull}) {
//   value = value.replaceAll(',', '');

//   double? doubleValue = double.tryParse(value);
//   if (doubleValue == null || doubleValue <= 0) return ifNull;
//   return 0;
//   // return doubleValue.to;
// }

int? validateInt(String? value, {int? ifNull}) {
  if (value == null) return ifNull;
  value = value.replaceAll(',', '');

  int? intValue = int.tryParse(value);
  if (intValue == null || intValue < 1) return ifNull;
  return intValue;
}

// void addThreeZeroes(
//   TextEditingController controller,
//   Function(Function()) setState,
// ) {
//   if (controller.text == '' ||
//       controller.text.length > 9 ||
//       validateDouble(controller.text, ifNull: 0) == 0) return;
//   double newText = validateDouble(controller.text, ifNull: 0)! * 1000;
//   setState(() => controller.text = moneyFormat(newText));
// }

String moneyFormat(double? value) {
  if (value == null || value == 0) return '0';
  return NumberFormat.currency(symbol: '').format(value);
}

String thousandFormat(int? value) {
  if (value == null || value == 0) return '0';
  return value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => m[1]!,
      );
}

String printRow(String col1, String col2, String col3) {
  int length = col1.length + 2 + col2.length + 2 + col3.length;

  int numOfSpaces = charactersPerRow - (length % charactersPerRow);
  return '$col1  $col2' + ' ' * numOfSpaces + '  $col3';
}

String preventWordBreak(String text, int limit) {
  int length = text.length;
  if (length <= limit || text[limit - 1] == ' ') return text;
  if (length > limit && text[limit] == ' ') return text;

  int lastIndex = text.substring(0, limit).lastIndexOf(' ');
  if (lastIndex == -1) return text;
  return text.substring(0, lastIndex) + '\n';
}

String preventWordBreakFullText(String text, int limit) {
  int length = text.length;
  if (length <= limit) return text;

  String newText = '';
  for (int i = 0; newText.length != length; i++) {
    if (i > 20) return text;
    newText += preventWordBreak(text.substring(newText.length), limit);
  }
  return newText;
}

String limitLength(String text, int limit) {
  if (text.length < limit) return text;
  return text.substring(0, limit - 3) + '...';
}

String addFullStop(String text) {
  if (text.characters.last == '.') return text;
  return text + '.';
}
