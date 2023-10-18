import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/features/news/screens/event_upsert.dart';
import 'package:smart_city/shared/config/date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.date,
    required this.title,
    required this.place,
    required this.placeUrl,
    required this.id,
    required this.emoji,
    required this.infoUrl,
  }) : super(key: key);
  final String id;
  final String date;
  final String title;
  final String place;
  final String placeUrl;
  final String emoji;
  final String infoUrl;

  @override
  Widget build(BuildContext context) {
    final Uri urlToPlace = Uri.parse(placeUrl);
    final Uri urlToInfo = Uri.parse(infoUrl);

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    final locale = Localizations.localeOf(context).languageCode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('$emoji  $title',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Text(
                    DateFormat(fullDateFormat, locale)
                        .format(DateTime.parse(date)),
                    style: TextStyle(color: Colors.grey.shade600),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchUrl(urlToPlace);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.place_rounded,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Text(place, style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  context.pushNamed(EventsUpsertScreen().route,
                      queryParameters: {'id': id});
                },
                icon: Icon(
                  Icons.edit,
                  size: 25,
                  color: Colors.grey.shade400.withOpacity(0.9),
                )),
            IconButton(
                onPressed: () {
                  _launchUrl(urlToInfo);
                },
                icon: Icon(
                  Icons.info,
                  size: 25,
                  color: Colors.grey.shade400.withOpacity(0.7),
                ))
          ],
        )
      ],
    );
  }
}
