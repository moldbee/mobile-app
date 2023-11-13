import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_city/features/events/controller.dart';
import 'package:smart_city/features/news/widgets/event_tile.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.find<EventsController>();

    return RefreshIndicator(
        onRefresh: () async {
          await eventsController.fetchEvents();
        },
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
            itemCount: eventsController.sortedByTimeEvents.length));
  }
}
