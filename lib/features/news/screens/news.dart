import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smart_city/features/news/widgets/tile.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({super.key});
  final String route = '/';
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final news = RxList([]);
    final isLoading = false.obs;
    final localiz = getAppLoc(context);

    fetchBaseNews() {
      isLoading.value = true;
      supabase
          .from('news')
          .select('id, title_${localiz!.localeName}, image, created_at')
          .order('id')
          .range(0, 10)
          .then((value) => news.value = value)
          .whenComplete(
            () => isLoading.value = false,
          );
    }

    useEffect(() {
      fetchBaseNews();

      return null;
    }, []);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(getAppLoc(context)!.news),
      ),
      body: Obx(() => LiquidPullToRefresh(
          animSpeedFactor: 3,
          color: Colors.orange.shade400,
          showChildOpacityTransition: false,
          springAnimationDurationInMilliseconds: 500,
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
            itemCount: news.length,
            isLoading: isLoading.value,
            itemBuilder: (context, index) {
              final newsItem = news[index];

              return NewsTile(
                title: newsItem['title_${localiz!.localeName}'],
                imageUrl: newsItem['image'],
                id: newsItem['id'],
                createdAt: newsItem['created_at'],
              );
            },
            onFetchData: () async {
              final query = supabase.from('news').select(
                  'id, title_${localiz!.localeName}, created_at, image');

              final newNews =
                  await query.order('id').range(news.length, news.length + 10);
              news.addAll(newNews);
            },
          ),
          onRefresh: () async {
            final query = supabase
                .from('news')
                .select('id, title_${localiz!.localeName}, created_at, image');

            final newNews = await query.order('id').range(0, 10);
            news.value = newNews;
          })),
    );
  }
}
