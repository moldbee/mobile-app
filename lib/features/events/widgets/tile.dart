import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/features/events/screens/details.dart';
import 'package:smart_city/l10n/main.dart';

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
  }) : super(key: key);
  final String id;
  final String date;
  final String title;
  final String place;
  final String placeUrl;
  final String? price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return GestureDetector(
      onTap: () {
        context.pushNamed(const EventDetailsScreen().route,
            queryParameters: {'id': id});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
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
                        color: Colors.grey.shade800,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat('d MMMM • HH:mm • EEEEE', locale)
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      price != null ? '$price lei' : getAppLoc(context)!.free,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
