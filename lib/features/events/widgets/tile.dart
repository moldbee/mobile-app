import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    Map getDate() {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      // final yesterday = DateTime(now.year, now.month, now.day - 1);
      final tomorrow = DateTime(now.year, now.month, now.day + 1);

      final dateToCheck = DateTime.parse(date);
      final eventDate =
          DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
      if (eventDate == today) {
        return {
          'text':
              '${getAppLoc(context)!.today}, ${DateFormat('d MMMM, HH:mm', locale).format(dateToCheck)}',
          'color': Colors.grey.shade600
        };
      } else if (eventDate == tomorrow) {
        return {
          'text':
              '${getAppLoc(context)!.tommorow}, ${DateFormat('d MMMM, HH:mm', locale).format(dateToCheck)}',
          'color': Colors.grey.shade600
        };
      }
      return {
        'text': DateFormat('${DateFormat.WEEKDAY}, d MMMM, HH:mm', locale)
            .format(DateTime.parse(date)),
        'color': Colors.grey.shade600
      };
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Stack(
      children: [
        Card(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 1, color: Colors.grey.shade300)),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://moldovaconcert.md/wp-content/uploads/2023/11/image-4.png',
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 150,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Esse voluptate sunt elit eu. dwa dad ad wad awd awd awd wa',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Divider(
                    //   height: 20,
                    //   thickness: .5,
                    //   color: Colors.grey.shade400,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '12:30',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          '12 September, 2023',
                          style: TextStyle(color: Colors.grey.shade500),
                          // style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Positioned(
            top: 25,
            right: 20,
            child: Wrapper(
              color: Colors.orange,
              child: Text(
                '1900 MDL',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            )),
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
