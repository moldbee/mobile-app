import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/controller.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class ProfileComments extends StatelessWidget {
  const ProfileComments({Key? key}) : super(key: key);
  final String route = '/profile/comments';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final newsController = Get.find<NewsController>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Мои комментарии'),
        ),
        body: profileController.comments.isEmpty
            ? Center(
                child: Text(
                  'Нет комментариев',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Obx(() => ListView.builder(
                      itemCount: profileController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = profileController.comments[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () async {
                              await newsController
                                  .fetchNewById(comment['new_id'].toString());

                              if (!context.mounted) return;
                              context.pushNamed(
                                const NewsDetailsScreen().route,
                                queryParameters: {
                                  'id': comment['new_id'].toString(),
                                  'commentId': comment['id'].toString()
                                },
                              );
                            },
                            child: ListTile(
                              title: Text(comment['message']),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        timeago.format(
                                            DateTime.parse(comment['created_at']
                                                .toString()),
                                            locale: 'ru'),
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.thumb_up_rounded,
                                            color: Colors.grey.shade400,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            comment['likes'].toString(),
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                              // trailing: Row(
                              //   children: [
                              //     Icon(Icons.thumb_up_rounded,
                              //         color: Colors.orange.shade400),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     Text(comment['likes'].toString()),
                              //   ],
                              // ),
                            ),
                          ),
                        );
                      },
                    )),
              ));
  }
}
