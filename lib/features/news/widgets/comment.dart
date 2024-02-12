import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class Comment extends HookWidget {
  const Comment({
    super.key,
    required this.onReply,
    required this.avatar,
    required this.setState,
    required this.nick,
    required this.authorId,
    required this.message,
    required this.setSelectedForReplyComment,
    required this.id,
    required this.newId,
    required this.comments,
    required this.onEdit,
    required this.createdAt,
    this.replyCommentId,
  });

  final Function(String id) onReply;
  final String message;
  final void Function(void Function()) setState;
  final List<dynamic>? comments;
  final String id;
  final String avatar;
  final String nick;
  final String authorId;
  final String newId;
  final Function(String id) onEdit;
  final Function(String? id) setSelectedForReplyComment;
  final String createdAt;
  final int? replyCommentId;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final likesStream = supabase
        .from('news_comments_likes')
        .stream(primaryKey: ['id']).eq('comment', id);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 26,
                    backgroundImage: NetworkImage(
                        avatar.length > 2 ? avatar : defaultAvatar),
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  nick,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  timeago.format(DateTime.parse(createdAt),
                                      locale: getAppLoc(context)!.localeName,
                                      allowFromNow: true),
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              StreamBuilder(
                  stream: likesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final isLiked = snapshot.data!.firstWhereOrNull(
                          (element) =>
                              element['user'].toString() ==
                              profileController.id.value.toString());
                      return GestureDetector(
                          onTap: () async {
                            HapticFeedback.lightImpact();
                            if (profileController.id.value != null) {
                              if (isLiked == null) {
                                await supabase
                                    .from('news_comments_likes')
                                    .upsert({
                                  'comment': id,
                                  'user': profileController.id.value
                                });
                              } else {
                                await supabase
                                    .from('news_comments_likes')
                                    .delete()
                                    .eq('comment', id)
                                    .eq('user', profileController.id.value);
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(getAppLoc(context)!.signInToLike),
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.all(20),
                                duration: const Duration(seconds: 2),
                              ));
                            }
                          },
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                  child: Text(
                                    NumberFormat.compactCurrency(
                                      decimalDigits: 0,
                                      symbol:
                                          '', // if you want to add currency symbol then pass that in this else leave it empty.
                                    ).format(snapshot.data!.length).toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: isLiked != null
                                            ? Colors.orange.shade600
                                            : Colors.grey.shade600),
                                  ),
                                ),
                                Icon(
                                  Icons.thumb_up,
                                  color: isLiked != null
                                      ? Colors.orange.shade600
                                      : Colors.grey.shade500,
                                ),
                              ]));
                    }

                    return const CircularProgressIndicator();
                  })
            ],
          ),
          if (replyCommentId != null &&
              comments?.firstWhereOrNull((element) =>
                      element['id'].toString() == replyCommentId.toString()) !=
                  null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border(
                        left:
                            BorderSide(width: 2, color: Colors.grey.shade300))),
                child: () {
                  final comment = comments?.firstWhere((element) =>
                      element['id'].toString() == replyCommentId.toString());
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        comment['created_by']['nick'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(comment['message'],
                              style: TextStyle(color: Colors.grey.shade800)))
                    ],
                  );
                }(),
              ),
            )
          ],
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (profileController.id.value is String) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (profileController.id.value != authorId) ...[
                    GestureDetector(
                      onTap: () {
                        onReply(id);
                      },
                      child: Text(
                        getAppLoc(context)!.reply,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                  if (nick == profileController.nick.value) ...[
                    GestureDetector(
                        onTap: () {
                          onEdit(id);
                        },
                        child: Text(getAppLoc(context)!.edit,
                            style: TextStyle(color: Colors.grey.shade600))),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => DeleteConfirmAlert(
                                  text: getAppLoc(context)!.sureDeleteComment,
                                  disableDoublePop: true,
                                  onDelete: () async {
                                    await supabase
                                        .from('news_comments_likes')
                                        .delete()
                                        .eq('comment', id);
                                    await supabase
                                        .from('news_comments')
                                        .delete()
                                        .eq('id', id);

                                    setState(() => {});
                                  }));
                        },
                        child: Text(getAppLoc(context)!.delete,
                            style: TextStyle(color: Colors.grey.shade600))),
                  ]
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
