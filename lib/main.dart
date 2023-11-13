import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_city/features/news/events_controller.dart';
import 'package:smart_city/features/news/news_controller.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/routes.dart';
import 'package:smart_city/shared/config/pallete.dart';
import 'package:smart_city/shared/config/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://caxhkekoeloyujcsovba.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNheGhrZWtvZWxveXVqY3NvdmJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQyMDM3MjUsImV4cCI6MjAwOTc3OTcyNX0.FwEigv5tFxLaKEfGZvvyg_JSSxYUkN3JFqKqNfTsavI',
  );
  await GetStorage.init();
  // await GetStorage().erase();
  Get.put(ProfileController());
  Get.put(NewsController());
  Get.put(EventsController());
  Get.put(ServicesController());
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

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
