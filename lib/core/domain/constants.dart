// import 'package:fiber/core/services/_utils/time_utils.dart';

class Constants {
  static RegExp emailRegExp = RegExp(
    r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  static String assetsPath = 'assets/images/';
}
