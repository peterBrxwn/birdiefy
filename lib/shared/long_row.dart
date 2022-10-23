import 'package:flutter/material.dart';

class LongRow extends StatelessWidget {
  const LongRow({
    required this.column1,
    required this.column2,
    required this.screenWidth,
    this.hasPadding = true,
    this.widgetKey,
    Key? key,
  }) : super(key: key);
  final String column1;
  final String column2;
  final bool hasPadding;
  final double screenWidth;
  final Key? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hasPadding ? 20 : 0,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: screenWidth / 3),
            child: Text(column1),
          ),
          const SizedBox(width: 20),
          Expanded(child: Text(column2, key: widgetKey)),
        ],
      ),
    );
  }
}
