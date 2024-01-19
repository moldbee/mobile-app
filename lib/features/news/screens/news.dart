import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/screens/events.dart';
import 'package:smart_city/features/news/widgets/news_body.dart';
import 'package:smart_city/features/news/screens/upsert.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/screens/intro_screen.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({Key? key}) : super(key: key);
  final String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppLoc(context)!.news),
        actions: [
          if (Permissions().getForNewsAndEvents()) ...[
            IconButton(
                onPressed: () {
                  context.push(NewsUpsertScreen().route);
                },
                icon: const Icon(
                  Icons.add_rounded,
                  size: 30,
                ))
          ],
          IconButton(
              onPressed: () {
                context.push(const EventsScreen().route);
              },
              icon: const Icon(Icons.event_rounded))
        ],
      ),
      body: const NewsScreenContentBody(),
    );
  }
}
