import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/features/events/screens/upsert.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:url_launcher/url_launcher.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.date,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.place,
    required this.placeUrl,
    required this.id,
    required this.infoUrl,
  }) : super(key: key);
  final String id;
  final String date;
  final String title;
  final String place;
  final String placeUrl;
  final String? price;
  final String imageUrl;
  final String infoUrl;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final Uri urlToPlace = Uri.parse(placeUrl);
    final Uri urlToInfo = Uri.parse(infoUrl);

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Stack(
      children: [
        Card(
          shadowColor: Colors.grey.shade100.withOpacity(0.3),
          surfaceTintColor: Colors.transparent,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 1, color: Colors.grey.shade300)),
          elevation: 3,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat('HH:mm • d MMMM yyyy • EEEEE', locale)
                          .format(DateTime.parse(date))
                          .capitalizeFirst as String,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      place,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 20,
            left: 20,
            child: Wrapper(
              color: Colors.orange,
              child: Text(
                price != null ? '$price MDL' : getAppLoc(context)!.free,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            )),
        if (Permissions().getForNewsAndEvents()) ...[
          Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(EventsUpsertScreen().route,
                      queryParameters: {'id': id});
                },
                child: Wrapper(
                  color: Colors.orange,
                  child: Text(
                    getAppLoc(context)!.edit,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ]
      ],
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key, required this.child, this.color}) : super(key: key);

  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? Colors.grey.shade800,
      ),
      child: child,
    );
  }
}
