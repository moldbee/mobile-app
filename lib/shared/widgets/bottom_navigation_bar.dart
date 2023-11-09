import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_city/features/profile/controller.dart';

Color bottomNavbarIconColor = Colors.white;
Color bottomNavbarSelectedIconColor = Colors.orange.shade400;

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, this.goBranch, this.index});

  final int? index;
  final dynamic goBranch;

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final accountIcon = Icon(
      Icons.account_circle,
      color: bottomNavbarIconColor,
    );
    final selectedAccountIcon = Icon(
      Icons.account_circle,
      color: bottomNavbarSelectedIconColor,
    );

    final avatarIcon = Container(
        decoration: const BoxDecoration(
            color: Colors.transparent, shape: BoxShape.circle),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 13,
          backgroundImage: NetworkImage(
            profileController.avatar.value,
          ),
        ));
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
            Icons.home_rounded,
            size: 28,
            weight: 900,
            opticalSize: 25,
            color: bottomNavbarSelectedIconColor,
          ),
          icon: Icon(
            Icons.home_rounded,
            weight: 900,
            opticalSize: 25,
            size: 28,
            color: bottomNavbarIconColor,
          ),
          label: '',
        ),
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
            Icons.widgets_rounded,
            color: bottomNavbarSelectedIconColor,
          ),
          icon: Icon(
            Icons.widgets_rounded,
            color: bottomNavbarIconColor,
          ),
          label: '',
        ),
        Obx(() {
          return NavigationDestination(
            selectedIcon: profileController.uid.value != null
                ? avatarIcon
                : selectedAccountIcon,
            icon:
                profileController.uid.value != null ? avatarIcon : accountIcon,
            label: '',
          );
        }),
      ],
    );
  }
}
