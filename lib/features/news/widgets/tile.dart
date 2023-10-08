import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 150,
                    height: 80,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 80,
                          width: 150,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
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
                            color: Colors.grey.shade800),
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
    timeago.setLocaleMessages('ro', timeago.RoMessages());
    timeago.setLocaleMessages('ru', timeago.RuMessages());

    return Text(
      timeago.format(time!, locale: 'ru'),
      style: TextStyle(color: Colors.grey.shade500),
    );
  }
}
