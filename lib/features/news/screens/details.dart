import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_city/features/news/widgets/comments_bottom_sheet.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends HookWidget {
  const NewsDetailsScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.category,
      required this.image,
      required this.commentsCount,
      required this.source})
      : super(key: key);
  static String route = '/news/details';
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String category;
  final String image;
  final String commentsCount;
  final String source;

  @override
  Widget build(BuildContext context) {
    showCommentsBottomSheet() {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18))),
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return CommentsBottomSheet(
                setState: setState,
                newId: id,
              );
            });
          });
    }

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
                child: Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 20),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800),
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
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: 20,
                            color: Colors.grey.shade400,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              commentsCount,
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize),
                            ),
                          )
                        ],
                      ),
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
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      color: Colors.grey.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      Text(
                        Uri.parse(source).host,
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              showCommentsBottomSheet();
                            },
                            child: Text(
                              getAppLoc(context)!.comments,
                            ))),
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
