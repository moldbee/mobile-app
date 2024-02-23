import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends HookWidget {
  const EventDetailsScreen({Key? key, this.id}) : super(key: key);
  final route = '/events/details';

  final String? id;

  @override
  Widget build(BuildContext context) {
    final event = usePreservedState('details-event-data', context, null);
    final localiz = getAppLoc(context);
    final localeName = localiz!.localeName;

    if (event.value == null) {
      supabase
          .from('events')
          .select(
              'title_$localeName, id, image_url, date, description_$localeName, price, place_$localeName, place_url, warnings')
          .eq('id', id)
          .single()
          .then((value) {
        event.value = value;
      });
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(localiz.event_details),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                event.value!['image_url'],
                fit: BoxFit.fill,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.value['title_${localiz.localeName}'],
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('d MMMM • HH:mm • EEEEE', localiz.localeName)
                          .format(DateTime.parse(event.value['date']))
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
                      event.value['description_${localiz.localeName}'],
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          color: Colors.grey.shade800),
                    ),
                    Visibility(
                      visible: event.value['warnings']?.length != null,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                const Icon(
                                  Icons.warning_rounded,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(event.value['warnings'][index]
                                      ['title_${localiz.localeName}']),
                                ),
                              ],
                            );
                          },
                          itemCount: event.value['warnings']?.length),
                    ),
                    const SizedBox(
                      height: 30,
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
                            event.value['price'] != null
                                ? '${event.value['price']} lei'
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
                              launchUrl(Uri.parse(event.value['place_url']!));
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
                                    event.value['place_${localiz.localeName}'],
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info_rounded,
                            color: Colors.white,
                          ),
                          label: Text(
                            localiz.info,
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
