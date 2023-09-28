import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class NewsTile extends StatelessWidget {
  const NewsTile(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.id,
      required this.createdAt})
      : super(key: key);

  final String title;
  final String imageUrl;
  final int id;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    final String heroKey = 'new_image$title';

    return GestureDetector(
      onTap: () {
        context.pushNamed(const NewsDetailsScreen().route,
            queryParameters: {'heroKey': heroKey, 'id': id.toString()});
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 150,
                  height: 80,
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade900),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: NewTime(
                          time: createdAt,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

class NewTime extends StatelessWidget {
  const NewTime({
    super.key,
    this.time,
  });

  final DateTime? time;

  @override
  Widget build(BuildContext context) {
    final difference = time!.difference(DateTime.now());
    timeago.setLocaleMessages('ro', timeago.RoMessages());
    timeago.setLocaleMessages('ru', timeago.RuMessages());

    return Text(
      timeago.format(time!, locale: 'ru'),
      style: TextStyle(color: Colors.grey.shade500),
    );
  }
}
