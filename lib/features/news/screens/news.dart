import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
    return DefaultTabController(
      length: 2,
      initialIndex: selectedTab.value,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Информация"),
            bottom: TabBar(
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
          body: TabBarView(children: [
            RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2));

                return;
              },
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewsTile(
                      title: 'Cillum in enim ullamco laborum anim.',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco laborum 1',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title: 'Cillum in enim ullamco laborum anim.  1',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco in enim ullamco. 2',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title: 'Cillum in enim ullamco laborum anim 1',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco 4',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco 5',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco 6',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco 8',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco 44',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                    NewsTile(
                      title:
                          'Cillum in enim ullamco laborum anim in enim ullamco 22',
                      imageUrl: 'assets/new_image.jpg',
                    ),
                  ],
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                print('Refreshing');
                await Future.delayed(const Duration(seconds: 2));

                return;
              },
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                crossAxisCount: 1,
                childAspectRatio: 3 / 1,
                children: const [
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                  EventTile(),
                ],
              ),
            )
          ])),
    );
  }
}
