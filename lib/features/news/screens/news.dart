import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/events_controller.dart';
import 'package:smart_city/features/news/news_controller.dart';
import 'package:smart_city/features/news/screens/event_upsert.dart';
import 'package:smart_city/features/news/screens/new_upsert.dart';
import 'package:smart_city/features/news/widgets/event_tile.dart';
import 'package:smart_city/features/news/widgets/tile.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({Key? key}) : super(key: key);
  final String route = '/';

  @override
  Widget build(BuildContext context) {
    final selectedTab = usePreservedState('news-tab', context, 0);
    final NewsController newsController = Get.find<NewsController>();
    final EventsController eventsController = Get.find<EventsController>();

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
            ],
          ),
          body: Obx(() {
            return TabBarView(children: [
              RefreshIndicator(
                onRefresh: () async {
                  await newsController.fetchNews();
                },
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemBuilder: (context, index) {
                    final news = newsController.sortedByTimeNews[index];

                    return NewsTile(
                      id: news['id'],
                      createdAt: DateTime.parse(news['created_at']),
                      title: news['title_ru'],
                      imageUrl: news['image'],
                    );
                  },
                  itemCount: newsController.sortedByTimeNews.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await eventsController.fetchEvents();

                  return;
                },
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    itemBuilder: (context, index) {
                      final event = eventsController.events[index];

                      return EventTile(
                          id: event['id'].toString(),
                          date: event['date'],
                          emoji: event['emoji'],
                          title: event['title_ru'],
                          place: event['place_ru'],
                          infoUrl: event['info_url'],
                          placeUrl: event['place_url']);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: eventsController.events.length),
              )
            ]);
          })),
    );
  }
}
