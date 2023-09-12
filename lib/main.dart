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
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
import 'package:smart_city/shared/config/pallete.dart';
import 'package:smart_city/shared/config/theme.dart';
import 'package:smart_city/shared/widgets/bottom_navigation_bar.dart';

void main() async {
  await GetStorage.init();
  // await GetStorage().erase();
  runApp(const MyApp());
}

final GoRouter _router =
    GoRouter(initialLocation: const NewsScreen().route, routes: <RouteBase>[
  ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
            body: child,
            bottomNavigationBar: CustomBottomNavigationBar(
              location: state.matchedLocation,
            ));
      },
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
        GoRoute(
            path: const ServicesScreen().route,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ServicesScreen())),
        GoRoute(
            path: const ServicesCompaniesScreen().route,
            pageBuilder: (context, state) =>
                const MaterialPage(child: ServicesCompaniesScreen())),
        GoRoute(
            path: const ProfileScreen().route,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen())),
        GoRoute(
            path: ProfileSignInScreen().route,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: ProfileSignInScreen())),
        GoRoute(
            path: ProfileSignUpScreen().route,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: ProfileSignUpScreen())),
        GoRoute(
            path: const SettingsScreen().route,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsScreen())),
      ])
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
        routerConfig: _router,
        theme: themeData,
        debugShowCheckedModeBanner: false,
        title: 'SmartCity',
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('ru'), Locale('ro')],
      ),
    );
  }
}
