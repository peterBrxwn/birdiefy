// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:birdiefy/utils/app_theme.dart';

class Notify {
  static void error(BuildContext context, [String? msg]) {
    msg = msg?.trim() ?? '';
    if (msg.isEmpty || msg.length > 150) {
      msg = 'Something went wrong. Please try again.';
    }

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 8,
      backgroundColor: Theme.of(context).errorColor,
      textColor: AppTheme.white,
    );
  }

  static void generic(BuildContext context, NotificationType type, String msg) {
    switch (type) {
      case NotificationType.error:
        Notify.error(context, msg);
        break;
      case NotificationType.info:
        Notify.info(context, msg);
        break;
      case NotificationType.success:
        Notify.success(context, msg);
        break;
    }
  }

  static void info(BuildContext context, String msg) {
    msg = msg.trim();
    if (msg.isEmpty || msg.length > 150) {
      msg = 'Something went wrong. Please try again.';
    }

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 8,
      backgroundColor: AppTheme.lightGrey,
      textColor: AppTheme.notBlack,
    );
  }

  static void success(BuildContext context, String msg) {
    msg = msg.trim();
    if (msg.isEmpty || msg.length > 150) msg = 'Successful.';

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 8,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: AppTheme.white,
    );
  }
}
