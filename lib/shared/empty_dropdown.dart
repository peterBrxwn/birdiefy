// Flutter imports:
import 'package:flutter/material.dart';

class EmptyDropdown extends StatelessWidget {
  final String message;
  const EmptyDropdown({Key? key, this.message = 'No items available.'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }
}
