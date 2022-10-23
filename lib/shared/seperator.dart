// Flutter imports:
import 'package:flutter/material.dart';

class Seperator extends StatelessWidget {
  final String text;
  const Seperator(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Divider(thickness: 1),
            ),
          ),
          Text(text),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Divider(thickness: 1),
            ),
          ),
        ],
      ),
    );
  }
}
