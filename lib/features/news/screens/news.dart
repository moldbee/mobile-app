import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:smart_city/features/news/widgets/tile.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../controller.dart';

class NewsTab extends HookWidget {
  const NewsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find<NewsController>();

    return RefreshIndicator(
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
    );
  }
}
