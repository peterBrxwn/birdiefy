import 'package:auto_route/auto_route.dart';
import 'package:birdiefy/routing/router.gr.dart';
import 'package:birdiefy/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  const TabPage({Key? key}) : super(key: key);

  static const routeName = 'tab';

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [RoundRoute(), UserRoute()],
      backgroundColor: AppTheme.background,
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: AppTheme.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.article_outlined,
                color: tabsRouter.activeIndex == 1 ? AppTheme.lightGrey : null,
              ),
              label: 'Rounds',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_outlined,
                color: tabsRouter.activeIndex == 0 ? AppTheme.lightGrey : null,
              ),
              label: 'User',
            ),
          ],
        );
      },
    );
  }
}
