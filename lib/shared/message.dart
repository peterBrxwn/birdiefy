// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:birdiefy/core/ext.dart';
import 'package:birdiefy/utils/app_theme.dart';

// Project imports:

class Message extends StatelessWidget {
  final bool showScaffold;
  final String message;
  final String? appBarTitle;
  const Message({
    Key? key,
    this.message = 'Something went wrong.',
    this.showScaffold = false,
    this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          message.addFullStop,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppTheme.white),
        ),
      ),
    );

    if (!showScaffold) return container;
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle != null
            ? Text(
                appBarTitle!,
                style: Theme.of(context).textTheme.headline5,
              )
            : null,
      ),
      body: container,
    );
  }
}
