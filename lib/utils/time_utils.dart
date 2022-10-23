// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeUtils {
  static int get nowMillis => DateTime.now().millisecondsSinceEpoch;
  static int get nowSeconds => (nowMillis * .001).round();

  static DateTime toDateTime(Timestamp val) => val.toDate();
  static DateTime toDate(Timestamp val) {
    DateTime dateTime = val.toDate();
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static DateTime? toDateTimeNullable(Timestamp? val) => val?.toDate();
  static DateTime? toDateNull(Timestamp? val) {
    if (val == null) return null;
    return toDate(val);
  }

  static DateTime getDate(DateTime val) {
    return DateTime(val.year, val.month, val.day);
  }

  static Timestamp fromDateTime(DateTime val) => Timestamp.fromDate(val);
  static Timestamp fromDate(DateTime val) {
    DateTime date = DateTime(val.year, val.month, val.day);
    return Timestamp.fromDate(date);
  }

  static Timestamp? fromDateTimeNullable(DateTime? val) {
    if (val == null) return null;
    return Timestamp.fromDate(val);
  }

  static Timestamp? fromDateNullable(DateTime? val) {
    if (val == null) return null;
    return fromDate(val);
  }

  static Timestamp fromMap(Map val) =>
      Timestamp(val['_seconds'], val['_nanoseconds']);
  static String shortDate(DateTime val) {
    String res = val.toString();
    return '${res.substring(8, 10)}/${res.substring(5, 7)}';
  }

  // static String shortDateFormat(DateTime val) {
  //   if (val.isAfter(stringToDateTime('Today')!) &&
  //       val.isBefore(stringToDateTime('Tomorrow')!)) {
  //     return format(val, allowFromNow: true);
  //   }
  //   return DateFormat('d MMM').format(val);
  // }

  static String shortDateRange(DateTime start, DateTime? end) {
    String selectedDateString = shortDate(start);
    if (end != null) selectedDateString += ' - ${TimeUtils.shortDate(end)}';
    return 'Select Date\n($selectedDateString)';
  }

  static String longDate(DateTime? val) => val.toString().substring(0, 10);
  static String longDateTime(DateTime val) => val.toString().substring(0, 19);

  static String dateInputFormat(DateTime? date) {
    if (date == null) return '';
    String dateString = date.toString();

    if (!dateString.contains('-')) return dateString.substring(0, 10);
    return '${dateString.substring(8, 10)}/${dateString.substring(5, 7)}/${dateString.substring(0, 4)}';
  }

  static String dateInputTest(DateTime? date) {
    if (date == null) return '';
    String dateString = date.toString();

    if (!dateString.contains('-')) return dateString.substring(0, 10);
    return dateString.substring(8, 10) +
        dateString.substring(5, 7) +
        dateString.substring(0, 4);
  }

  static String reverseDateInputFormat(String date) {
    if (date.isEmpty) return '';
    String dateString = date.toString();

    if (!dateString.contains('/')) return dateString.substring(0, 10);
    int? part1 = int.tryParse(dateString.substring(6, 10));
    int? part2 = int.tryParse(dateString.substring(3, 5));
    int? part3 = int.tryParse(dateString.substring(0, 2));

    if (part1 == null || part2 == null || part3 == null) return '';
    if (part3 > 31 || part3 < 1) return '';
    if (part2 > 12 || part2 < 1) return '';
    if (part3 > 30) {
      if (part2 == 9 || part2 == 4 || part2 == 6 || part2 == 11) return '';
    }
    if (part1 > 2050 || part1 < 2020) return '';

    return '${dateString.substring(6, 10)}-${dateString.substring(3, 5)}-${dateString.substring(0, 2)}';
  }

  static DateTime? stringToDateTime(String? string) {
    final DateTime now = DateTime.now();
    if (string == 'Tomorrow') return DateTime(now.year, now.month, now.day + 1);
    if (string == 'Today') return DateTime(now.year, now.month, now.day);
    if (string == 'Yesterday') {
      return DateTime(now.year, now.month, now.day - 1);
    }
    if (string == 'This Week') {
      return DateTime(now.year, now.month, now.day - now.weekday + 1);
    }
    if (string == 'This Month') return DateTime(now.year, now.month);
    if (string == 'Next Month') {
      return DateTime(now.year, now.month + 1, now.day);
    }
    if (string == 'Tomorrow Next Month') {
      return DateTime(now.year, now.month + 1, now.day + 1);
    }
    if (string == 'A Month Ago') {
      return DateTime(now.year, now.month - 1, now.day);
    }
    if (string == 'This Quarter') {
      int month = now.month % 3;
      return DateTime(now.year, now.month - month);
    }
    if (string == 'This Year') return DateTime(now.year);
    if (string == 'All Time' || string == 'A Year Ago') {
      return DateTime(now.year - 1);
    }
    return null;
  }
}
