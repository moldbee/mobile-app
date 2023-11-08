import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_city/features/news/news_controller.dart';
import 'package:smart_city/features/news/screens/new_upsert.dart';
import 'package:smart_city/features/news/widgets/comments_bottom_sheet.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';

class NewsDetailsScreen extends HookWidget {
  const NewsDetailsScreen({Key? key, this.id, this.commentId})
      : super(key: key);
  final String route = '/news/details';
  final String? id;
  final String? commentId;

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();
    final newData = newsController.news.firstWhere((element) {
      return element['id'].toString() == id;
    });
    final comments = useState([]);

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
                highlightId: commentId,
                setState: setState,
                setComments: (value) {
                  if (context.mounted) {
                    setState(() {
                      comments.value = value;
                    });
                  }
                },
                newId: id,
                comments: comments.value,
              );
            });
          });
    }

    useEffect(() {
      if (commentId == null) {
        newsController
            .fetchCommentsForNew(newData['id'].toString())
            .then((value) => comments.value = value);
      }

      if (commentId != null) {
        Future.delayed(const Duration(milliseconds: 0), () async {
          final res = await newsController
              .fetchCommentsForNew(newData['id'].toString());
          comments.value = res;
          showCommentsBottomSheet();
        });
      }
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статья'),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => DeleteConfirmAlert(
                          onDelete: () async {
                            await newsController.deleteNew(id);
                          },
                        ));
              },
              icon: const Icon(Icons.delete_rounded)),
          IconButton(
              onPressed: () {
                context.pushNamed(NewsUpsertScreen().route,
                    queryParameters: {'id': id});
              },
              icon: const Icon(
                Icons.edit_rounded,
                size: 26,
              )),
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.share_rounded,
          //       size: 26,
          //     ))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 20),
                child: Text(
                  newData['title_ru'],
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800),
                ),
              ),
              CachedNetworkImage(
                imageUrl: newData['image'],
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
                          Icons.remove_red_eye,
                          size: 22,
                          color: Colors.grey.shade400,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '2503',
                            style: TextStyle(color: Colors.grey.shade500),
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
                              comments.value.length.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
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
                child: Text(
                  newData['description_ru'],
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
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
                            child: const Text(
                              'Комментарии',
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
