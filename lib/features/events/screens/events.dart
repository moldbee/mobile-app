import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_city/features/events/controller.dart';
import 'package:smart_city/features/events/widgets/tile.dart';
import 'package:smart_city/l10n/main.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.find<EventsController>();

    return Obx(() => RefreshIndicator(
        onRefresh: () async {
          await eventsController.fetchEvents();
        },
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
            itemCount: eventsController.sortedByTimeEvents.length)));
  }
}
