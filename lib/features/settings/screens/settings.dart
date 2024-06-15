import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/controller.dart';
import 'package:smart_city/features/settings/screens/contacts.dart';
import 'package:smart_city/l10n/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  final String route = '/settings';
  final SizedBox spacing = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    const double blockHeight = 40;
    final globalController = Get.find<GlobalController>();

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(getAppLoc(context)!.language,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    TextButton(
                      onPressed: () {
                        globalController.locale.value = const Locale('ru');
                      },
                      child: Text(getAppLoc(context)!.russian),
                    ),
                    TextButton(
                      onPressed: () {
                        globalController.locale.value = const Locale('ro');
                      },
                      child: Text(getAppLoc(context)!.romanian),
                    )
                  ],
                ),
              ),
              spacing,
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(getAppLoc(context)!.contacts,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(const ContactsScreen().route);
                      },
                      child: Text(getAppLoc(context)!.contacts),
                    ),
                  ],
                ),
              ),
              spacing,
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(getAppLoc(context)!.share,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(getAppLoc(context)!.share),
                    ),
                  ],
                ),
              ),
              spacing,
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(getAppLoc(context)!.version,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("1.0.0",
                          style: TextStyle(color: Colors.grey.shade800)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
