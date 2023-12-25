import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/screens/events.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/news/screens/upsert.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/permissions.dart';

class InfoScreen extends HookWidget {
  const InfoScreen({Key? key}) : super(key: key);
  final String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   width: 200,
      //   child: ListView(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(
      //           'Categories',
      //           style: TextStyle(
      //               fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
      //         ),
      //       ),
      //       ListView.builder(
      //         physics: const NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         itemBuilder: (context, index) {
      //           return Row(children: [
      //             Padding(
      //               padding: const EdgeInsets.only(left: 10),
      //               child: FilterChip(
      //                 onSelected: (isd) {},
      //                 label: const Text(
      //                   'Hello world',
      //                   style: TextStyle(color: Colors.white),
      //                 ),
      //                 checkmarkColor: Colors.white,
      //                 iconTheme: IconThemeData(
      //                   color: Colors.white,
      //                 ),
      //                 selected: true,
      //               ),
      //             ),
      //           ]);
      //         },
      //         itemCount: 10,
      //       )
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(
        //         Icons.menu,
        //         size: 30,
        //       ),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
        // // leading: IconButton(
        // //   icon: const Icon(
        // //     Icons.menu_rounded,
        // //     size: 30,
        // //   ),
        // //   onPressed: () {},
        // // ),
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
                context.push(EventsScreen().route);
              },
              icon: const Icon(Icons.event_rounded))
        ],
      ),
      body: const NewsTab(),
    );
  }
}
