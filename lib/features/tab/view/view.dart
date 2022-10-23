import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/routing/router.gr.dart';
import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  const TabPage({Key? key}) : super(key: key);

  static const routeName = 'tab';

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [RoundRoute(), UserRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: 'Inventory',
            ),
          ],
        );
      },
    );
  }
}
