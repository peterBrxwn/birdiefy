import 'package:flutter/material.dart';

class LongTextRow extends StatelessWidget {
  const LongTextRow({
    required this.text1,
    required this.text2,
    this.widgetKey,
    this.hPadding = true,
    Key? key,
  }) : super(key: key);
  final String text1;
  final String text2;
  final Key? widgetKey;
  final bool hPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hPadding ? 20 : 0,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 3,
            ),
            child: Text(text1),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(text2, key: widgetKey),
          ),
        ],
      ),
    );
  }
}
