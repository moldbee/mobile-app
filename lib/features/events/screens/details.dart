import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/features/events/controller.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({Key? key, this.id}) : super(key: key);
  final route = '/events/details';

  final String? id;

  @override
  Widget build(BuildContext context) {
    final eventsController = Get.find<EventsController>();

    final selectedEvent = eventsController.events
        .firstWhereOrNull((event) => event['id'].toString() == id);

    final localiz = getAppLoc(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали события'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            selectedEvent!['image_url'],
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedEvent['title_${localiz!.localeName}'],
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('HH:mm • d MMMM yyyy • EEEEE', localiz.localeName)
                      .format(DateTime.parse(selectedEvent['date']))
                      .capitalizeFirst as String,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge!.fontSize),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Dolor enim sunt voluptate Lorem commodo commodo. Consectetur proident dolor sit ad culpa qui duis enim culpa. Consectetur nisi quis adipisicing dolor id magna sunt ad labore voluptate reprehenderit.',
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      color: Colors.grey.shade800),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade400,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        selectedEvent['price'] != null
                            ? '${selectedEvent['price']} MDL'
                            : getAppLoc(context)!.free,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .fontSize),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse(selectedEvent['place_url']!));
                        },
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey.shade400,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                selectedEvent['place_${localiz.localeName}'],
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .fontSize),
                              ),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
