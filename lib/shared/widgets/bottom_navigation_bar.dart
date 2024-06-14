import 'package:flutter/material.dart';

Color bottomNavbarIconColor = Colors.white;
Color bottomNavbarSelectedIconColor = Colors.orange.shade300;

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, this.goBranch, this.index});

  final int? index;
  final dynamic goBranch;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index as int,
      surfaceTintColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (value) {
        goBranch(value);
      },
      height: 50,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.newspaper_rounded,
            color: bottomNavbarSelectedIconColor,
          ),
          icon: Icon(
            Icons.newspaper_rounded,
            color: bottomNavbarIconColor,
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.local_activity_rounded,
            size: 26,
            weight: 900,
            color: bottomNavbarSelectedIconColor,
          ),
          icon: Icon(
            Icons.local_activity_rounded,
            size: 26,
            weight: 900,
            color: bottomNavbarIconColor,
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.widgets_rounded,
            color: bottomNavbarSelectedIconColor,
          ),
          icon: Icon(
            Icons.widgets_rounded,
            color: bottomNavbarIconColor,
          ),
          label: '',
        ),
      ],
    );
  }
}
