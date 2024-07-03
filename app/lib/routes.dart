import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/controller.dart';
import 'package:smart_city/features/auth/screens/auth.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/services/screens/company_services.dart';
import 'package:smart_city/features/services/screens/contacts.dart';
import 'package:smart_city/features/services/screens/details.dart';
import 'package:smart_city/features/services/screens/discounts.dart';
import 'package:smart_city/features/services/screens/faq.dart';
import 'package:smart_city/features/services/screens/info.dart';
import 'package:smart_city/features/services/screens/offices.dart';
import 'package:smart_city/features/services/screens/promotions.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/settings/screens/contacts.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
import 'package:smart_city/features/transport/screens/how_to_add_route.dart';
import 'package:smart_city/features/transport/screens/search.dart';
import 'package:smart_city/features/transport/screens/transport.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/features/news/screens/news.dart';

import 'features/services/screens/items.dart';
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
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: const NewsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: NewsScreen())),
          GoRoute(
              name: NewsDetailsScreen.route,
              path: NewsDetailsScreen.route,
              pageBuilder: (context, state) {
                final params = state.uri.queryParameters as Map;
                return MaterialPage(
                    child: NewsDetailsScreen(
                        category: params['category'],
                        id: params['id'],
                        description: params['description'],
                        image: params['image'],
                        source: params['source'],
                        title: params['title'],
                        createdAt: params['createdAt']));
              }),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: const TransportScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: TransportScreen())),
          GoRoute(
              name: const HowToAddRouteScreen().route,
              path: const HowToAddRouteScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: HowToAddRouteScreen())),
          GoRoute(
              name: const RoutesScreen().route,
              path: const RoutesScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: RoutesScreen())),
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
        routes: [
          GoRoute(
              path: const AuthScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: AuthScreen())),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: const SettingsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: SettingsScreen())),
          GoRoute(
              path: const ContactsScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ContactsScreen())),
        ],
      ),
    ],
  ),
]);
