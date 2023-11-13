import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/screens/events.dart';
import 'package:smart_city/features/events/screens/upsert.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/news/screens/upsert.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';

class InfoScreen extends HookWidget {
  const InfoScreen({Key? key}) : super(key: key);
  final String route = '/';

  @override
  Widget build(BuildContext context) {
    final selectedTab = usePreservedState('news-tab', context, 0);

    return DefaultTabController(
      length: 2,
      initialIndex: selectedTab.value,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Информация"),
            bottom: TabBar(
              physics: const NeverScrollableScrollPhysics(),
              onTap: (index) {
                selectedTab.value = index;
              },
              tabs: const <Widget>[
                Tab(
                    icon: Text(
                  'Новости',
                )),
                Tab(
                  icon: Text('Афиша'),
                ),
              ],
            ),
            actions: [
              if (Permissions().getForNewsAndEvents()) ...[
                IconButton(
                    onPressed: () {
                      context.push(selectedTab.value == 0
                          ? NewsUpsertScreen().route
                          : EventsUpsertScreen().route);
                    },
                    icon: const Icon(
                      Icons.add_rounded,
                      size: 30,
                    ))
              ]
            ],
          ),
          body: const TabBarView(children: [NewsTab(), EventsTab()])),
    );
  }
}
