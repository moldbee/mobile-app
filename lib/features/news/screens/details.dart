import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_city/features/news/widgets/comments_bottom_sheet.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends HookWidget {
  const NewsDetailsScreen({Key? key, this.id, this.commentId})
      : super(key: key);
  final String route = '/news/details';
  final String? id;
  final String? commentId;

  @override
  Widget build(BuildContext context) {
    final isLoading = false.obs;
    final newData = usePreservedState('new-data', context, {});
    final commentsCount = useState(0);
    final localiz = getAppLoc(context);

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

    final locale = getAppLoc(context)!.localeName;

    if (newData.value['id'] == null) {
      supabase
          .from('news')
          .select(
              'title_${localiz!.localeName}, description_${localiz.localeName}, image, source, created_at, id')
          .eq('id', id)
          .single()
          .then((value) {
        newData.value = value;
        supabase
            .from('news_comments')
            .select('id, new_id',
                const FetchOptions(count: CountOption.exact, head: true))
            .eq('new_id', value['id'])
            .then((total) {
          return commentsCount.value = total.count;
        });
      }).whenComplete(() => isLoading.value = false);
      return const Center(
        child: CircularProgressIndicator(),
      );
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 20),
                child: Text(
                  newData.value['title_$locale'],
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800),
                ),
              ),
              CachedNetworkImage(
                imageUrl: newData.value['image'],
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
                                .format(DateTime.parse(
                                    newData.value['created_at'])),
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
                              commentsCount.value.toString(),
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
                  text: newData.value['description_$locale'],
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
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
                child: GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(newData.value['source']));
                  },
                  child: Row(
                    children: [
                      Image.network(
                          '${Uri.parse(newData.value['source']).origin}/favicon.ico',
                          width: 20,
                          scale: 0.9,
                          height: 20),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        Uri.parse(newData.value['source']).host,
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
