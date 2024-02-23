import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/l10n/main.dart';
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
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.pushNamed(const NewsDetailsScreen().route,
              queryParameters: {'id': id.toString()});
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 170,
                  height: 90,
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 90,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .fontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800),
                      ),
                    ),
                    NewTime(
                      time: createdAt,
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}

class NewTime extends StatelessWidget {
  const NewTime({
    super.key,
    required this.time,
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ro', timeago.RoMessages());
    timeago.setLocaleMessages('ru', timeago.RuMessages());

    return Text(
      timeago.format(DateTime.parse(time),
          locale: getAppLoc(context)!.localeName),
      style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize),
    );
  }
}
