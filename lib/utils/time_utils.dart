// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static DateTime toDateTime(Timestamp date) => date.toDate();
  static Timestamp fromDateTime(DateTime date) => Timestamp.fromDate(date);
  static String shortDateString(DateTime date) =>
      DateFormat("MMM dd").format(date);
  static String shortDateFormat(DateTime date) =>
      DateFormat("dd-MM-yyyy").format(date);
  static String reverseDateInputFormat(String date) {
    if (date.isEmpty) return '';
    final dateString = date.toString();

    if (!dateString.contains('/')) return dateString.substring(0, 10);
    final part1 = int.tryParse(dateString.substring(6, 10));
    final part2 = int.tryParse(dateString.substring(3, 5));
    final part3 = int.tryParse(dateString.substring(0, 2));

    if (part1 == null || part2 == null || part3 == null) return '';
    if (part3 > 31 || part3 < 1) return '';
    if (part2 > 12 || part2 < 1) return '';
    if (part3 > 30) {
      if (part2 == 9 || part2 == 4 || part2 == 6 || part2 == 11) return '';
    }
    if (part1 > 2050 || part1 < 2020) return '';

    return '${dateString.substring(6, 10)}-${dateString.substring(3, 5)}-${dateString.substring(0, 2)}';
  }
}
