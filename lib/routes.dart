import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/controller.dart';
import 'package:smart_city/features/events/screens/events.dart';
import 'package:smart_city/features/events/screens/details.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/edit.dart';
import 'package:smart_city/features/profile/screens/notifications.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/features/services/screens/company_services.dart';
import 'package:smart_city/features/services/screens/contacts.dart';
import 'package:smart_city/features/services/screens/details.dart';
import 'package:smart_city/features/services/screens/discounts.dart';
import 'package:smart_city/features/services/screens/faq.dart';
import 'package:smart_city/features/services/screens/info.dart';
import 'package:smart_city/features/services/screens/offices.dart';
import 'package:smart_city/features/services/screens/promotions.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/settings/screens/about.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/shared/screens/intro_screen.dart';
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

      final storage = GetStorage();
      final isViewedIntroScreen =
          (storage.read('isViewedIntroScreen') == true).obs;

      onSkip() {
        storage.write('isViewedIntroScreen', true);
        isViewedIntroScreen.value = true;
      }

      return Obx(() {
        if (!isViewedIntroScreen.value) {
          return IntroScreen(
            onSkip: onSkip,
            onDone: onSkip,
          );
        }

        return Scaffold(
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
        );
      });
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: const NewsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: NewsScreen())),
          GoRoute(
              name: const NewsDetailsScreen().route,
              path: const NewsDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: NewsDetailsScreen(
                        id: state.uri.queryParameters['id'],
                        commentId: state.uri.queryParameters['commentId']));
              }),
        ],
      ),
      StatefulShellBranch(
        initialLocation: const EventsScreen().route,
        routes: [
          GoRoute(
              path: const EventsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: EventsScreen())),
          GoRoute(
              name: const EventDetailsScreen().route,
              path: const EventDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: EventDetailsScreen(
                  id: state.uri.queryParameters['id'],
                ));
              }),
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
          GoRoute(
              name: const CompanyServicesScreen().route,
              path: const CompanyServicesScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CompanyServicesScreen(
                  id: state.uri.queryParameters['companyId'],
                ));
              }),
          GoRoute(
              name: const CompanyContactsScreen().route,
              path: const CompanyContactsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CompanyContactsScreen(
                  id: state.uri.queryParameters['companyId'],
                ));
              }),
          GoRoute(
              name: const CompanyPromotionsScreen().route,
              path: const CompanyPromotionsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CompanyPromotionsScreen(
                  id: state.uri.queryParameters['companyId'],
                ));
              }),
          GoRoute(
              name: const CompanyInfoScreen().route,
              path: const CompanyInfoScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CompanyInfoScreen(
                  id: state.uri.queryParameters['companyId'],
                ));
              }),
          GoRoute(
              name: const CompanyFaqScreen().route,
              path: const CompanyFaqScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CompanyFaqScreen(
                  id: state.uri.queryParameters['companyId'],
                ));
              }),
          GoRoute(
              name: const CompanyOfficesScreen().route,
              path: const CompanyOfficesScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CompanyOfficesScreen(
                  id: state.uri.queryParameters['companyId'],
                ));
              }),
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
