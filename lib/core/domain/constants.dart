// import 'package:fiber/core/services/_utils/time_utils.dart';

class Constants {
  static const int versionCode = 56;
  static const String versionShort = 'v2.1.3';
  static const int charactersPerRow = 32;
  static const bool isTest = false;
  static RegExp passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    caseSensitive: true,
    multiLine: false,
  );
  static RegExp emailRegExp = RegExp(
    r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  static const Map<String, dynamic> defaultCurrency = {
    'code': 'NGN',
    'name': 'Nigeria Naira',
    'symbol': '₦',
    'flag': 'NGN',
    'number': 566,
    'decimal_digits': 2,
    'name_plural': 'Nigerian nairas',
    'decimal_separator': '.',
    'thousands_separator': ',',
    'symbol_on_left': true,
    'space_between_amount_and_symbol': false,
  };
  static const String revenueCatIOSPublicKey =
      'appl_aqXuRvWNKFFCrjLWkBQFMuEINMi';
  static const String revenueCatAndroidPublicKey =
      'goog_yIBUQuIACNkmBHvaVEBzIWWmnqS';
  static const String revenueCatStripePublicKey =
      'strp_hIaFmqRoQTIjMCvmbypRvhOpeMg';
  static const String vapidKey =
      'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUs'
      'E1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA';
  static const String basicPlanEId = 'basic';
  static const String standardPlanEId = 'standard';
  static const String premiumPlanEId = 'platinum';
  static const List<String> plansEId = [
    basicPlanEId,
    standardPlanEId,
    premiumPlanEId
  ];
  static const String privacyPolicyLink = 'https://fiber.ng/privacy-policy';
  static const String termsOfUseLink = 'https://fiber.ng/terms-of-use';
  static const String contactSupportLink = 'https://fiber.ng/contact-us';
  static const String iOSBluetoothHelpLink = 'https://youtu.be/q0Idr7MvC4I';
  static const String androidBluetoothHelpLink =
      'https://fiber.ng/links/android-printing';
  static const List<String> timePeriodArr = [
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    'This Year',
    'All Time',
    'Select Date',
  ];
  // static const List<DateEnum> dateEnumArr = [
  //   DateEnum.today,
  //   DateEnum.yesterday,
  //   DateEnum.thisWeek,
  //   DateEnum.thisMonth,
  //   DateEnum.thisYear,
  //   DateEnum.allTime,
  //   // DateEnum.selectDate,
  // ];
  static const List<String> monthsLabel = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  static String staffAccountInfo = 'NB: Sorry you can\'t create a staff '
      'account from here. Rather tell Business owner to create one for you. To '
      'do that, the business owner should go to "People Tab" -> "Add Staff" '
      'and add your details.';
  static RegExp wordNumberRegex = RegExp('[A-Za-z0-9]');
  static RegExp notWordNumberRegex = RegExp('[^A-Za-z0-9]');
  static RegExp wordNumberUnderscoreHyphenSpaceRegex = RegExp('[A-Za-z0-9 _-]');
  static RegExp notwordNumberUnderscoreHyphenSpaceRegex =
      RegExp('[^A-Za-z0-9 _-]');
  static String rememberMeKey = 'rememberMe';
  static double screenPadding = 20;
  static String printDashes = '--------------------------------';
}
