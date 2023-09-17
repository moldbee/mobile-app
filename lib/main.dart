import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/news/screens/event_upsert.dart';
import 'package:smart_city/features/news/screens/new_upsert.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/features/services/screens/companies.dart';
import 'package:smart_city/features/services/screens/other.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/services/widgets/details.dart';
import 'package:smart_city/features/settings/screens/about.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
import 'package:smart_city/shared/animations/slide_page_transition.dart';
import 'package:smart_city/shared/config/pallete.dart';
import 'package:smart_city/shared/config/theme.dart';
import 'package:smart_city/shared/screens/policy.dart';
import 'package:smart_city/shared/widgets/bottom_navigation_bar.dart';

void main() async {
  await GetStorage.init();
  // await GetStorage().erase();
  runApp(const MyApp());
}

final GoRouter router = GoRouter(routes: <RouteBase>[
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      Future<bool> onBackPressed() async {
        return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Confirm'),
                  content: const Text('Do you want to exit the App'),
                  actions: <Widget>[
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(false); //Will not exit the App
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true); //Will exit the App
                      },
                    )
                  ],
                );
              },
            ) ??
            false;
      }

      return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          goBranch: navigationShell.goBranch,
          index: navigationShell.currentIndex,
        ),
        body: WillPopScope(onWillPop: onBackPressed, child: navigationShell),
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: const NewsScreen().route,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: NewsScreen())),
          GoRoute(
              path: NewsUpsertScreen().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: NewsUpsertScreen())),
          GoRoute(
              path: EventsUpsertScreen().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: EventsUpsertScreen())),
          GoRoute(
              name: const NewsDetailsScreen().route,
              path: const NewsDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: Hero(
                        tag: state.uri.queryParameters['heroKey'] as String,
                        child: const NewsDetailsScreen()));
              }),
        ],
      ),
      StatefulShellBranch(
        initialLocation: const ServicesScreen().route,
        routes: [
          GoRoute(
              path: const ServicesScreen().route,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ServicesScreen())),
          GoRoute(
              path: const ServicesCompaniesScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ServicesCompaniesScreen())),
          GoRoute(
              path: const ServicesOtherScreen().route,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ServicesOtherScreen())),
          GoRoute(
              name: const ServiceDetailsScreen().route,
              path: const ServiceDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: ServiceDetailsScreen(
                  logoUrl: state.uri.queryParameters['logoUrl'],
                  title: state.uri.queryParameters['title'] as String,
                ));
              }),
        ],
      ),
      StatefulShellBranch(
        initialLocation: ProfileSignInScreen().route,
        routes: [
          GoRoute(
              path: ProfileSignInScreen().route,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ProfileSignInScreen())),
          GoRoute(
              path: ProfileSignUpScreen().route,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ProfileSignUpScreen())),
          GoRoute(
              path: const ProfileScreen().route,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen())),
          GoRoute(
              path: const PolicyScreen().route,
              pageBuilder: (context, state) =>
                  wrapPageSlideTransition(const PolicyScreen()))
        ],
      ),
      StatefulShellBranch(
        initialLocation: const SettingsScreen().route,
        routes: [
          GoRoute(
              path: const SettingsScreen().route,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SettingsScreen())),
          GoRoute(
              path: const AboutScreen().route,
              pageBuilder: (context, state) =>
                  wrapPageSlideTransition(const AboutScreen()))
        ],
      ),
    ],
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: blackColor,
        systemNavigationBarColor: blackColor,
        systemNavigationBarDividerColor: blackColor,
        systemNavigationBarIconBrightness: Brightness.dark));
    return SafeArea(
      child: MaterialApp.router(
        routerConfig: router,
        theme: themeData,
        debugShowCheckedModeBanner: false,
        title: 'SmartCity',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('ru'), Locale('ro')],
      ),
    );
  }
}
