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
    final categories = RxList([]);
    final news = RxList([]);
    final isLoading = false.obs;
    final selectedCategory = RxnInt(null);
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

      supabase
          .from('news_categories')
          .select('id, title_${localiz!.localeName}')
          .then((value) => categories.value = value);

      return null;
    }, []);

    return Scaffold(
      key: scaffoldKey,
      drawer: Obx(() => Drawer(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory.value == category['id'];

                return GestureDetector(
                  onTap: () async {
                    final query = supabase.from('news').select(
                        'id, title_${localiz.localeName}, image, created_at');
                    if (isSelected) {
                      selectedCategory.value = null;
                    } else {
                      selectedCategory.value = category['id'];
                      query.eq('category', category['id']);
                    }
                    final newNews = await query.order('id').range(0, 10);
                    news.value = newNews;
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        side: BorderSide(
                          style: BorderStyle.solid,
                          width: .5,
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade500,
                        ),
                        backgroundColor: isSelected
                            ? Colors.orange.shade500
                            : Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        labelStyle: TextStyle(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade800,
                          fontSize:
                              Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        label: Text(category['title_${localiz!.localeName}']),
                      ),
                    ],
                  ),
                );
              },
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
            ),
          )),
      appBar: AppBar(
        actions: [
          Obx(() => Visibility(
              visible: selectedCategory.value != null,
              child: IconButton(
                icon: const Icon(Icons.filter_alt_off),
                onPressed: () {
                  selectedCategory.value = null;
                  fetchBaseNews();
                },
              )))
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 29,
          ),
          onPressed: () async {
            final fetchedCategories = await supabase
                .from('news_categories')
                .select('id, title_${localiz!.localeName}');
            categories.value = fetchedCategories;
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Obx(() => Text(selectedCategory.value != null
            ? categories.firstWhereOrNull((element) =>
                element['id'] ==
                selectedCategory.value)['title_${localiz!.localeName}']
            : getAppLoc(context)!.news)),
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

              if (selectedCategory.value != null) {
                query.eq('category', selectedCategory);
              }

              final newNews =
                  await query.order('id').range(news.length, news.length + 10);
              news.addAll(newNews);
            },
          ),
          onRefresh: () async {
            final query = supabase
                .from('news')
                .select('id, title_${localiz!.localeName}, created_at, image');

            if (selectedCategory.value != null) {
              query.eq('category', selectedCategory);
            }

            final newNews = await query.order('id').range(0, 10);
            news.value = newNews;
          })),
    );
  }
}
