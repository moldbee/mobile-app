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
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({Key? key}) : super(key: key);
  final String route = '/info';

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
          body: Obx(() {
            return TabBarView(children: [
              RefreshIndicator(
                onRefresh: () async {
                  newsController.refetchNews();
                },
                child: InfiniteList(
                  itemBuilder: (context, index) {
                    final news = newsController.news[index];
                    return NewsTile(
                      id: news['id'],
                      createdAt: DateTime.parse(news['created_at']),
                      title: news['title_ru'],
                      imageUrl: news['image'],
                    );
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  loadingBuilder: (context) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  isLoading: newsController.isLoading.value,
                  itemCount: newsController.news.length,
                  hasReachedMax: newsController.hasReachedMax.value,
                  onFetchData: () {
                    newsController.fetchNews(
                        start: newsController.news.length,
                        end: newsController.news.length + 10);
                  },
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await eventsController.fetchEvents();
                },
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    itemBuilder: (context, index) {
                      final event = eventsController.sortedByTimeEvents[index];

                      return EventTile(
                          paid: event['paid'],
                          id: event['id'].toString(),
                          date: event['date'],
                          emoji: event['emoji'],
                          title: event['title_ru'],
                          place: event['place_ru'],
                          infoUrl: event['info_url'],
                          placeUrl: event['place_url']);
                    },
                    itemCount: eventsController.sortedByTimeEvents.length),
              )
            ]);
          })),
    );
  }
}
