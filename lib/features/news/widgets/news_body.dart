import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:smart_city/features/news/widgets/tile.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../controller.dart';

class NewsScreenContentBody extends HookWidget {
  const NewsScreenContentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find<NewsController>();

    return Obx(() => RefreshIndicator(
        child: InfiniteList(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade200,
            height: 30,
          ),
          loadingBuilder: (context) => const Center(
            child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: CircularProgressIndicator()),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          itemCount: newsController.newsSortedByTime.length,
          isLoading: newsController.isLoading.value,
          itemBuilder: (context, index) {
            final newsItem = newsController.newsSortedByTime[index];
            final locale = getAppLoc(context)!.localeName;
            return NewsTile(
              title: newsItem['title_$locale'],
              imageUrl: newsItem['image'],
              id: newsItem['id'],
              createdAt: newsItem['created_at'],
            );
          },
          onFetchData: () async {
            await newsController.fetchNews(
                start: newsController.news.length,
                end: newsController.news.length + 10);
          },
        ),
        onRefresh: () async {
          newsController.loadedAllNews.value = false;
          newsController.news.value = [];
          await newsController.fetchNews();
        }));
  }
}
