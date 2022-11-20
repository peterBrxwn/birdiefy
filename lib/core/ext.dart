// Flutter imports:
import 'package:flutter/material.dart';

extension ParseNumbers on String {
  String get addFullStop {
    if (characters.last == '.') return this;
    return '$this.';
  }
}
