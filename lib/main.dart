import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_city/controller.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/routes.dart';
import 'package:smart_city/shared/config/pallete.dart';
import 'package:smart_city/shared/config/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  // await dotenv.load(fileName: ".env.prod");
  await dotenv.load(fileName: '.env.dev');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await GetStorage.init();

  // await GetStorage().erase();
  Get.put(GlobalController());
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
    final locale = Get.find<GlobalController>().locale;
    return SafeArea(
      child: Obx(() {
        return MaterialApp.router(
          scrollBehavior: const MaterialScrollBehavior(),
          routerConfig: router,
          theme: getThemeData(context),
          debugShowCheckedModeBanner: false,
          title: 'Moldbee',
          locale: locale.value,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      }),
    );
  }
}
