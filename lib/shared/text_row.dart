import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  const TextRow({
    required this.col1,
    required this.col2,
    this.widgetKey,
    Key? key,
  }) : super(key: key);
  final String col1;
  final String col2;
  final Key? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(col1),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            col2,
            key: key,
          ),
        ],
      ),
    );
  }
}
