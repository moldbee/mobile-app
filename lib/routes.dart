import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/controller.dart';
import 'package:smart_city/features/emergencies/screens/emergencies.dart';
import 'package:smart_city/features/events/screens/events.dart';
import 'package:smart_city/features/events/screens/upsert.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/news/screens/upsert.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/edit.dart';
import 'package:smart_city/features/profile/screens/my_comments.dart';
import 'package:smart_city/features/profile/screens/notifications.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/features/services/screens/alert_upsert.dart';
import 'package:smart_city/features/services/screens/category_upsert.dart';
import 'package:smart_city/features/services/screens/details.dart';
import 'package:smart_city/features/services/screens/discount_upsert.dart';
import 'package:smart_city/features/services/screens/discounts.dart';
import 'package:smart_city/features/services/screens/info_upsert.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/services/screens/upsert.dart';
import 'package:smart_city/features/settings/screens/about.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/screens/info.dart';
import 'package:smart_city/shared/screens/policy.dart';

import 'features/services/screens/items.dart';
import 'features/settings/screens/settings.dart';
import 'shared/widgets/bottom_navigation_bar.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      DateTime? currentBackPressTime = DateTime.now();
      final globalState = Get.find<GlobalController>();
      Future<bool> onWillPop() {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime as DateTime) >
            const Duration(milliseconds: 500)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 500),
            backgroundColor: Colors.grey.shade900,
            content: Text(
              getAppLoc(context)!.tapAgainToExit,
              style: const TextStyle(color: Colors.white),
            ),
          ));
          return Future.value(false);
        }
        return Future.value(true);
      }

      return Obx(() => Scaffold(
            floatingActionButton: globalState.isLoading.value
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: const CircularProgressIndicator(),
                  )
                : null,
            bottomNavigationBar: CustomBottomNavigationBar(
              goBranch: navigationShell.goBranch,
              index: navigationShell.currentIndex,
            ),
            // ignore: deprecated_member_use
            body: WillPopScope(onWillPop: onWillPop, child: navigationShell),
          ));
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: const InfoScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: InfoScreen())),
          GoRoute(
              name: NewsUpsertScreen().route,
              path: NewsUpsertScreen().route,
              pageBuilder: (context, state) => MaterialPage(
                      child: NewsUpsertScreen(
                    id: state.uri.queryParameters['id'],
                  ))),
          GoRoute(
              name: EventsUpsertScreen().route,
              path: EventsUpsertScreen().route,
              pageBuilder: (context, state) => MaterialPage(
                      child: EventsUpsertScreen(
                    id: state.uri.queryParameters['id'],
                  ))),
          GoRoute(
              name: const NewsDetailsScreen().route,
              path: const NewsDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: NewsDetailsScreen(
                        id: state.uri.queryParameters['id'],
                        commentId: state.uri.queryParameters['commentId']));
              }),
          GoRoute(
              path: const EventsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: EventsScreen())),
        ],
      ),
      StatefulShellBranch(
        initialLocation: const ServicesScreen().route,
        routes: [
          GoRoute(
              path: const ServicesScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ServicesScreen())),
          GoRoute(
              path: const DiscountsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: DiscountsScreen())),
          GoRoute(
              path: const ServiceCategoryUpsert().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ServiceCategoryUpsert())),
          GoRoute(
              name: const ServiceInfoUpsert().route,
              path: const ServiceInfoUpsert().route,
              pageBuilder: (context, state) => MaterialPage(
                  child: ServiceInfoUpsert(
                      serviceId: state.uri.queryParameters['serviceId'],
                      infoId: state.uri.queryParameters['infoId']))),
          GoRoute(
              name: const ServiceDiscountUpsert().route,
              path: const ServiceDiscountUpsert().route,
              pageBuilder: (context, state) => MaterialPage(
                  child: ServiceDiscountUpsert(
                      serviceId: state.uri.queryParameters['serviceId'],
                      discountId: state.uri.queryParameters['discountId']))),
          GoRoute(
              name: const ServiceAlertUpsert().route,
              path: const ServiceAlertUpsert().route,
              pageBuilder: (context, state) => MaterialPage(
                  child: ServiceAlertUpsert(
                      serviceId: state.uri.queryParameters['serviceId'],
                      alertId: state.uri.queryParameters['alertId']))),
          GoRoute(
              name: ServiceUpsert().route,
              path: ServiceUpsert().route,
              pageBuilder: (context, state) => MaterialPage(
                      child: ServiceUpsert(
                    categoryId: state.uri.queryParameters['categoryId'],
                    serviceId: state.uri.queryParameters['serviceId'],
                  ))),
          GoRoute(
              path: const ServicesCompaniesScreen().route,
              name: const ServicesCompaniesScreen().route,
              pageBuilder: (context, state) => MaterialPage(
                  child: ServicesCompaniesScreen(
                      categoryId: state.uri.queryParameters['categoryId']))),
          GoRoute(
              name: const ServiceDetailsScreen().route,
              path: const ServiceDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: ServiceDetailsScreen(
                  serviceId: state.uri.queryParameters['serviceId'],
                ));
              }),
        ],
      ),
      StatefulShellBranch(
        initialLocation: const EmergenciesScreen().route,
        routes: [
          GoRoute(
              path: const EmergenciesScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: EmergenciesScreen())),
        ],
      ),
      StatefulShellBranch(
        initialLocation: ProfileSignInScreen().route,
        routes: [
          GoRoute(
              redirect: (context, state) {
                final ProfileController profileController =
                    Get.find<ProfileController>();

                if (profileController.uid.value != null) {
                  return ProfileScreen().route;
                }

                return ProfileSignInScreen().route;
              },
              path: ProfileSignInScreen().route,
              name: ProfileSignInScreen().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: ProfileSignInScreen())),
          GoRoute(
              path: ProfileSignUpScreen().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: ProfileSignUpScreen())),
          GoRoute(
              path: const ProfileComments().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ProfileComments())),
          GoRoute(
              path: const ProfileNotifications().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ProfileNotifications())),
          GoRoute(
              path: const ProfileEdit().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ProfileEdit())),
          GoRoute(
              path: ProfileScreen().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: ProfileScreen())),
          GoRoute(
              path: const PolicyScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: PolicyScreen())),
          GoRoute(
              path: const SettingsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: SettingsScreen())),
          GoRoute(
              path: const AboutScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: AboutScreen()))
        ],
      ),
    ],
  ),
]);
