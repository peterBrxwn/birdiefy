import 'package:flutter/material.dart';

class AdaptableRow extends StatelessWidget {
  const AdaptableRow({required this.text1, required this.text2, Key? key})
      : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    bool longText = text2.length > 15;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!longText)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(text1),
              ),
            ),
          if (longText) Text(text1),
          const SizedBox(width: 20),
          if (longText)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(text2),
              ),
            ),
          if (!longText) Text(text2),
        ],
      ),
    );
  }
}
