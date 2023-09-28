import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/controller.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/news/screens/event_upsert.dart';
import 'package:smart_city/features/news/screens/new_upsert.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/features/services/screens/companies.dart';
import 'package:smart_city/features/services/screens/other.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/services/screens/upsert.dart';
import 'package:smart_city/features/services/widgets/details.dart';
import 'package:smart_city/features/settings/screens/about.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
import 'package:smart_city/shared/animations/slide_page_transition.dart';
import 'package:smart_city/shared/config/pallete.dart';
import 'package:smart_city/shared/config/theme.dart';
import 'package:smart_city/shared/screens/policy.dart';
import 'package:smart_city/shared/widgets/bottom_navigation_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://caxhkekoeloyujcsovba.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNheGhrZWtvZWxveXVqY3NvdmJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQyMDM3MjUsImV4cCI6MjAwOTc3OTcyNX0.FwEigv5tFxLaKEfGZvvyg_JSSxYUkN3JFqKqNfTsavI',
  );
  // await GetStorage().erase();
  await GetStorage.init();
  Get.put(ProfileController());
  Get.put(NewsController());
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

final GoRouter router = GoRouter(routes: <RouteBase>[
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      DateTime currentBackPressTime = DateTime.now();

      Future<bool> onWillPop() {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.grey.shade900,
            content: const Text(
              'Нажмите еще раз, чтобы выйти',
              style: TextStyle(color: Colors.white),
            ),
          ));
          return Future.value(false);
        }
        return Future.value(true);
      }

      return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          goBranch: navigationShell.goBranch,
          index: navigationShell.currentIndex,
        ),
        body: WillPopScope(onWillPop: onWillPop, child: navigationShell),
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
              name: NewsUpsertScreen().route,
              path: NewsUpsertScreen().route,
              pageBuilder: (context, state) => MaterialPage(
                      child: NewsUpsertScreen(
                    id: state.uri.queryParameters['id'],
                  ))),
          GoRoute(
              path: EventsUpsertScreen().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: EventsUpsertScreen())),
          GoRoute(
              name: const NewsDetailsScreen().route,
              path: const NewsDetailsScreen().route,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: NewsDetailsScreen(
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
                  const NoTransitionPage(child: ServicesScreen())),
          GoRoute(
              path: ServiceUpsert().route,
              pageBuilder: (context, state) =>
                  MaterialPage(child: ServiceUpsert())),
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
                  MaterialPage(child: ProfileSignUpScreen())),
          GoRoute(
              path: ProfileScreen().route,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: ProfileScreen())),
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
        scrollBehavior: const MaterialScrollBehavior(),
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
