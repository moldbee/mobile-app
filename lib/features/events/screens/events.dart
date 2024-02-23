import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smart_city/features/events/controller.dart';
import 'package:smart_city/features/events/widgets/tile.dart';
import 'package:smart_city/l10n/main.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);
  final route = '/events';

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.find<EventsController>();

    return Scaffold(
        appBar: AppBar(
          title: Text(getAppLoc(context)!.events),
        ),
        body: Obx(() => LiquidPullToRefresh(
            animSpeedFactor: 3,
            springAnimationDurationInMilliseconds: 500,
            color: Colors.orange.shade400,
            showChildOpacityTransition: false,
            onRefresh: () async {
              await eventsController.fetchEvents();
            },
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                itemBuilder: (context, index) {
                  final event = eventsController.sortedByTimeEvents[index];
                  final locale = getAppLoc(context)!.localeName;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: EventTile(
                        price: event['price'],
                        id: event['id'].toString(),
                        date: event['date'],
                        title: event['title_$locale'],
                        place: event['place_$locale'],
                        imageUrl: event['image_url'],
                        placeUrl: event['place_url']),
                  );
                },
                itemCount: eventsController.sortedByTimeEvents.length))));
  }
}
