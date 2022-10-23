// Flutter imports:
import 'package:flutter/material.dart';

class FaWrapper extends StatelessWidget {
  final IconData icon;
  final Color? color;
  const FaWrapper(this.icon, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(context) => Icon(icon, color: color, size: 18);
}
