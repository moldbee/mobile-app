import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/settings/screens/settings.dart';

Color bottomNavbarIconColor = Colors.white;
Color bottomNavbarSelectedIconColor = Colors.orange.shade400;

List<String> routes = [
  const NewsScreen().route,
  const ServicesScreen().route,
  ProfileSignInScreen().route,
  const SettingsScreen().route,
];

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.location});
  final String? location;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: NavigationBar(
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        selectedIndex: routes.indexWhere((element) => element == location),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) {
          context.go(routes[value]);
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
              Icons.apartment_rounded,
              color: bottomNavbarSelectedIconColor,
              size: 28,
            ),
            icon: Icon(
              Icons.apartment_rounded,
              color: bottomNavbarIconColor,
              size: 28,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle,
              color: bottomNavbarSelectedIconColor,
            ),
            icon: Icon(
              Icons.account_circle,
              color: bottomNavbarIconColor,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.settings,
              color: bottomNavbarSelectedIconColor,
            ),
            icon: Icon(
              Icons.settings,
              color: bottomNavbarIconColor,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
