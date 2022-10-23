// Flutter imports:
import 'package:flutter/material.dart';

class RemoveFocus extends StatefulWidget {
  final Widget child;
  const RemoveFocus({required this.child, Key? key}) : super(key: key);

  @override
  _RemoveFocusState createState() => _RemoveFocusState();
}

class _RemoveFocusState extends State<RemoveFocus> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: widget.child,
    );
  }
}
