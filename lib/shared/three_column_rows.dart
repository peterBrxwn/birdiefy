import 'package:flutter/material.dart';

class ThreeColumnRows extends StatelessWidget {
  const ThreeColumnRows({
    required this.column1,
    required this.column2,
    required this.column3,
    this.column4,
    Key? key,
  }) : super(key: key);
  final String column1;
  final String column2;
  final String column3;
  final String? column4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(column1),
          const SizedBox(width: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(column2),
            ),
          ),
          const SizedBox(width: 20),
          if (column4 != null)
            Text(column4!, style: Theme.of(context).textTheme.overline),
          Text(column3),
        ],
      ),
    );
  }
}
