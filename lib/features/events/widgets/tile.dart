import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/features/events/screens/upsert.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:url_launcher/url_launcher.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.date,
    required this.price,
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
  final String? price;
  final String emoji;
  final String infoUrl;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final Uri urlToPlace = Uri.parse(placeUrl);
    final Uri urlToInfo = Uri.parse(infoUrl);
    getDate() {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final tomorrow = DateTime(now.year, now.month, now.day + 1);

      final dateToCheck = DateTime.parse(date);
      final eventDate =
          DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
      if (eventDate == today) {
        return 'cегодня, ${DateFormat('d MMMM, HH:mm', locale).format(dateToCheck)}';
      } else if (eventDate == yesterday) {
        return 'вчера, ${DateFormat('d MMMM, HH:mm', locale).format(dateToCheck)}';
      } else if (eventDate == tomorrow) {
        return 'завтра, ${DateFormat('d MMMM, HH:mm', locale).format(dateToCheck)}';
      }
      return DateFormat('${DateFormat.WEEKDAY} d MMMM, HH:mm', locale)
          .format(DateTime.parse(date));
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(3, 0, 30, 0),
                      child: Text('$emoji   $title',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrl(urlToInfo);
                    },
                    child: Icon(
                      Icons.info,
                      size: 23,
                      color: Colors.grey.shade400.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        Text(
                          getDate(),
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                      ],
                    ),
                    if (Permissions().getForNewsAndEvents()) ...[
                      GestureDetector(
                        child: Icon(
                          Icons.edit,
                          size: 23,
                          color: Colors.grey.shade400.withOpacity(0.9),
                        ),
                        onTap: () {
                          context.pushNamed(EventsUpsertScreen().route,
                              queryParameters: {'id': id});
                        },
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchUrl(urlToPlace);
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Icon(
                              Icons.place_rounded,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(place,
                              style: TextStyle(color: Colors.grey.shade600))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.attach_money_rounded,
                            color: Colors.orange.shade400,
                          ),
                        ),
                        Text(price ?? 'Бесплатно',
                            style: TextStyle(color: Colors.grey.shade600))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
