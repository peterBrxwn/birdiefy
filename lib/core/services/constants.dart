const int versionCode = 56;
const String versionShort = 'v2.1.3';
const int charactersPerRow = 32;
bool isTest = true;
RegExp emailRegExp = RegExp(
  r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$',
  caseSensitive: false,
  multiLine: false,
);
Map<String, dynamic> defaultCurrency = {
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
const String revenueCatIOSPublicKey = 'appl_aqXuRvWNKFFCrjLWkBQFMuEINMi';
const String revenueCatAndroidPublicKey = 'goog_yIBUQuIACNkmBHvaVEBzIWWmnqS';
const String revenueCatStripePublicKey = 'strp_hIaFmqRoQTIjMCvmbypRvhOpeMg';
const String vapidKey = 'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUs'
    'E1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA';
const String basicPlanEId = 'basic';
const String standardPlanEId = 'standard';
const String premiumPlanEId = 'platinum';
const List<String> plansEId = [basicPlanEId, standardPlanEId, premiumPlanEId];
const String privacyPolicyLink = 'https://fiber.ng/privacy-policy';
const String termsOfUseLink = 'https://fiber.ng/terms-of-use';
const String contactSupportLink = 'https://fiber.ng/contact-us';
const String iOSBluetoothHelpLink = 'https://youtu.be/q0Idr7MvC4I';
const String androidBluetoothHelpLink =
    'https://fiber.ng/links/android-printing';
const List<String> timePeriodArr = [
  'Today',
  'Yesterday',
  'This Week',
  'This Month',
  'This Year',
  'All Time',
  'Select Date',
];
const List<String> monthsLabel = [
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
String staffAccountInfo = 'NB: Sorry you can\'t create a staff account from '
    'here. Rather tell Business owner to create one for you. To do that, the '
    'business owner should go to "People Tab" -> "Add Staff" and add your '
    'details.';
RegExp wordNumberRegex = RegExp('[A-Za-z0-9]');
RegExp notWordNumberRegex = RegExp('[^A-Za-z0-9]');
RegExp wordNumberUnderscoreHyphenSpaceRegex = RegExp('[A-Za-z0-9 _-]');
RegExp notwordNumberUnderscoreHyphenSpaceRegex = RegExp('[^A-Za-z0-9 _-]');
String rememberMeKey = 'rememberMe';
double screenPadding = 20;
String printDashes = '--------------------------------';
