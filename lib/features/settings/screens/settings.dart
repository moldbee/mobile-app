import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/controller.dart';
import 'package:smart_city/features/settings/screens/about.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  final String route = '/settings';
  final SizedBox spacing = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    const double blockHeight = 40;
    final globalController = Get.find<GlobalController>();

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.info),
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
                    const Expanded(
                      child: Text(
                        "Язык",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        globalController.locale.value = const Locale('ru');
                      },
                      child: const Text("Русский"),
                    ),
                    TextButton(
                      onPressed: () {
                        globalController.locale.value = const Locale('ro');
                      },
                      child: const Text("Румынский"),
                    )
                  ],
                ),
              ),
              spacing,
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "О приложении",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(const AboutScreen().route);
                      },
                      child: const Text("О приложении"),
                    ),
                  ],
                ),
              ),
              spacing,
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Поделиться",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Поделиться"),
                    ),
                  ],
                ),
              ),
              spacing,
              SizedBox(
                height: blockHeight,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Версия",
                        style: TextStyle(fontSize: 14),
                      ),
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
