// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool showScaffold;
  const Loading({Key? key, this.showScaffold = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: kIsWeb || Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(),
      ),
    );

    if (!showScaffold) return container;
    return Scaffold(
      appBar: AppBar(),
      body: container,
    );
  }
}
