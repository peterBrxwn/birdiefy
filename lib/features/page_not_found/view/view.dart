// Flutter imports:
import 'package:flutter/material.dart';

class PageNotFoundPage extends StatelessWidget {
  const PageNotFoundPage({Key? key}) : super(key: key);

  static const routeName = 'page-not-found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '404 Error!',
              style: Theme.of(context).textTheme.headline5!,
            ),
            const SizedBox(height: 20),
            const Text('The page you are trying to access cannot be found.'),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
