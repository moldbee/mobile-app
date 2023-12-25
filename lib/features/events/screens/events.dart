import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/controller.dart';
import 'package:smart_city/features/events/screens/upsert.dart';
import 'package:smart_city/features/events/widgets/tile.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/permissions.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);
  final route = '/events';

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.find<EventsController>();

    return Scaffold(
        appBar: AppBar(
          title: Text(getAppLoc(context)!.events),
          actions: [
            if (Permissions().getForNewsAndEvents()) ...[
              IconButton(
                  onPressed: () {
                    context.push(EventsUpsertScreen().route);
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 30,
                  ))
            ]
          ],
        ),
        body: Obx(() => RefreshIndicator(
            onRefresh: () async {
              await eventsController.fetchEvents();
            },
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                itemBuilder: (context, index) {
                  final event = eventsController.sortedByTimeEvents[index];
                  final locale = getAppLoc(context)!.localeName;
                  return EventTile(
                      price: event['price'],
                      id: event['id'].toString(),
                      date: event['date'],
                      emoji: event['emoji'],
                      title: event['title_$locale'],
                      place: event['place_$locale'],
                      infoUrl: event['info_url'],
                      placeUrl: event['place_url']);
                },
                itemCount: eventsController.sortedByTimeEvents.length))));
  }
}
