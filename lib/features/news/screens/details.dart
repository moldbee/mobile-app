import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/pallete.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends HookWidget {
  const NewsDetailsScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.category,
      required this.image,
      required this.source});
  static String route = '/news/details';
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String category;
  final String image;
  final String source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppLoc(context)!.article),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(category,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 20),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.grey.shade800),
                ),
              ),
              CachedNetworkImage(
                imageUrl: image,
                height: 220,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.date_range_rounded,
                          size: 22,
                          color: Colors.grey.shade400,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            DateFormat('dd MMMM yyyy, HH:mm',
                                    getAppLoc(context)!.localeName)
                                .format(DateTime.parse(createdAt)),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: mutedColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Linkify(
                    text: description,
                    onOpen: (link) async {
                      final url = Uri.parse(link.url);

                      launchUrl(url);
                    },
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(source));
                  },
                  child: Row(
                    children: [
                      Image.network('${Uri.parse(source).origin}/favicon.ico',
                          width: 20, scale: 0.9, height: 20),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(Uri.parse(source).host,
                          style: Theme.of(context).textTheme.bodyLarge!)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
