import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smart_city/features/news/controller.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:smooth_highlight/smooth_highlight.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class CommentsBottomSheet extends HookWidget {
  const CommentsBottomSheet(
      {Key? key,
      this.newId,
      this.comments,
      this.setComments,
      this.highlightId,
      required this.setState})
      : super(key: key);
  static final _formKey = GlobalKey<FormBuilderState>();

  final String? newId;
  final String? highlightId;
  final void Function(void Function()) setState;
  final dynamic comments;
  final Function(dynamic value)? setComments;

  @override
  Widget build(BuildContext context) {
    final highlightCount = useState(0);
    final newsController = Get.find<NewsController>();
    final selectedForReplyComment = useState<String?>(null);
    final ProfileController profileController = Get.find<ProfileController>();
    final commentIdForEdit = usePreservedState('commentIdForEdit', context);
    final formState =
        usePreservedState('comment-form-state', context, {'comment': ''});
    void onCommentEdit(String id) {
      commentIdForEdit.value = id;
      final selectedForEditComment =
          comments.firstWhere((element) => element['id'].toString() == id);
      _formKey.currentState
          ?.patchValue({'comment': selectedForEditComment['message']});
      selectedForReplyComment.value =
          selectedForEditComment['reply_comment_id'] is int
              ? selectedForEditComment['reply_comment_id'].toString()
              : null;
    }

    final highlightIndex = comments
        ?.indexWhere((element) => element['id'].toString() == highlightId);

    useEffect(() {
      final highlightTimer =
          Timer.periodic(const Duration(milliseconds: 300), (timer) async {
        if (highlightId != null) {
          highlightCount.value = highlightCount.value + 1;
        }
      });
      // Timer timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      //   if (newId != null) {
      //     setComments!(await newsController.fetchCommentsForNew(newId));
      //   }
      // });

      Future.delayed(const Duration(seconds: 2), () {
        highlightTimer.cancel();
      });
      return () {
        // timer.cancel();
        highlightTimer.cancel();
      };
    }, []);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: .5, color: Colors.grey.shade300))),
          height: 50,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Комментарии',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              if (comments!.isNotEmpty) ...[
                ScrollablePositionedList.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ValueChangeHighlight(
                          enabled:
                              highlightIndex == index && highlightId != null,
                          value: highlightCount.value,
                          color: Colors.orange.shade100.withOpacity(0.5),
                          child: Comment(
                            onEdit: onCommentEdit,
                            comments: comments,
                            setSelectedForReplyComment: (id) {
                              selectedForReplyComment.value = id;
                            },
                            setComments: setComments!,
                            newId: newId!,
                            id: comment['id'].toString(),
                            nick: comment['created_by']['nick'],
                            avatar: comment['created_by']['avatar'],
                            createdAt: comment['created_at'],
                            replyCommentId: comment['reply_comment_id'],
                            message: comment['message'],
                            onReply: (id) {
                              selectedForReplyComment.value = id;
                            },
                          ),
                        ),
                      );
                    })
              ] else
                const NoCommentsMessage()
            ]),
          ),
        ),
        if (selectedForReplyComment.value != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: .5, color: Colors.grey.shade300)),
            ),
            child: () {
              final comment = comments?.firstWhere((element) =>
                  element['id'].toString() ==
                  selectedForReplyComment.value.toString());
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              comment['created_by']['avatar'] ?? defaultAvatar),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['created_by']['nick'],
                              ),
                              Text(
                                comment['message'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: IconButton(
                      onPressed: () {
                        selectedForReplyComment.value = null;
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 28,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              );
            }(),
          )
        ],
        Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: .5, color: Colors.grey.shade400))),
            child: profileController.id.value is String
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FormBuilder(
                        initialValue: const {'comment': ''},
                        key: _formKey,
                        onChanged: () {
                          _formKey.currentState?.save();
                          formState.value = _formKey.currentState?.value;
                        },
                        child: const Expanded(
                          child: TextInput(
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 19),
                            disableBorders: true,
                            name: 'comment',
                            minLines: 1,
                            maxLines: 5,
                            hintText: 'Введите комментарий',
                            title: '',
                          ),
                        ),
                      ),
                      if (commentIdForEdit.value != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: IconButton(
                              onPressed: () async {
                                _formKey.currentState!.reset();
                                selectedForReplyComment.value = null;
                                commentIdForEdit.value = null;
                                if (!context.mounted) return;
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.cancel_schedule_send_rounded,
                                color: Colors.grey.shade400,
                              )),
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: IconButton(
                            onPressed: () async {
                              if (_formKey
                                      .currentState!.value['comment']?.length <
                                  2) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  showCloseIcon: true,
                                  content: Text(
                                      'Комментарий должен быть не менее 5 символов'),
                                  backgroundColor: Colors.red,
                                ));
                                return;
                              }
                              if (_formKey.currentState!.saveAndValidate()) {
                                dynamic comment = {
                                  'new_id': newId,
                                  'message': formState.value['comment'],
                                  'created_by': int.parse(
                                      profileController.id.value as String)
                                };
                                if (commentIdForEdit.value != null) {
                                  comment['id'] = commentIdForEdit.value;
                                }

                                comment['reply_comment_id'] =
                                    selectedForReplyComment.value;
                                await supabase
                                    .from('news_comments')
                                    .upsert(comment);
                                setComments!(await newsController
                                    .fetchCommentsForNew(newId));
                                _formKey.currentState!.reset();
                                selectedForReplyComment.value = null;
                                commentIdForEdit.value = null;
                                if (!context.mounted) return;
                                FocusScope.of(context).unfocus();
                              }
                            },
                            icon: Icon(
                              commentIdForEdit.value != null
                                  ? Icons.done_rounded
                                  : Icons.send_rounded,
                              color: Colors.grey.shade400,
                            )),
                      )
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      context.go(ProfileSignInScreen().route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                'Что бы оставить комментарий, вам необходимо войти в аккаунт',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 14)),
                          )
                        ],
                      ),
                    ),
                  )),
      ]),
    );
  }
}

class Comment extends HookWidget {
  const Comment({
    super.key,
    required this.onReply,
    required this.message,
    required this.setSelectedForReplyComment,
    required this.id,
    required this.nick,
    required this.newId,
    required this.setComments,
    required this.comments,
    required this.avatar,
    required this.onEdit,
    required this.createdAt,
    this.replyCommentId,
  });

  final Function(String id) onReply;
  final String message;
  final List<dynamic>? comments;
  final Function setComments;
  final String id;
  final String nick;
  final String newId;
  final Function(String? id) setSelectedForReplyComment;
  final String? avatar;
  final String createdAt;
  final void Function(String id) onEdit;
  final int? replyCommentId;

  @override
  Widget build(BuildContext context) {
    final isLiked = useState(false);
    final likes = useState('0');
    final profileController = Get.find<ProfileController>();
    final newsController = Get.find<NewsController>();

    Future<void> fetchLikesInfo() async {
      newsController.getLikesForComment(id).then((value) {
        if (!context.mounted) return null;
        return likes.value = value.count.toString();
      });
      newsController.getHasLiked(id, profileController.id.value).then((value) {
        if (!context.mounted) return null;
        return isLiked.value = value;
      });
    }

    useEffect(() {
      fetchLikesInfo();
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    radius: 26,
                    backgroundImage: NetworkImage(avatar ?? defaultAvatar),
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
                                      locale: 'ru'),
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
              GestureDetector(
                onTap: () async {
                  if (profileController.id.value != null) {
                    await newsController.toggleLike(
                        id, profileController.id.value);
                    await fetchLikesInfo();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Войдите в аккаунт'),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(20),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        likes.value,
                        style: TextStyle(
                            fontSize: 16,
                            color: isLiked.value
                                ? Colors.orange.shade600
                                : Colors.grey.shade600),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.thumb_up_rounded,
                      color: isLiked.value
                          ? Colors.orange.shade400
                          : Colors.grey.shade400,
                    ),
                  ],
                ),
              )
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
                  GestureDetector(
                    onTap: () {
                      onReply(id);
                    },
                    child: Text(
                      'Ответить',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // Text(
                  //   'Пожаловаться',
                  //   style: TextStyle(color: Colors.grey.shade600),
                  // ),
                  if (nick == profileController.nick.value ||
                      Permissions().getForComments()) ...[
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          onEdit(id);
                        },
                        child: Text('Редактировать',
                            style: TextStyle(color: Colors.grey.shade600))),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => DeleteConfirmAlert(
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
                                    setComments(await newsController
                                        .fetchCommentsForNew(newId));
                                  }));
                        },
                        child: Text('Удалить',
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

class NoCommentsMessage extends StatelessWidget {
  const NoCommentsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 100 * 30),
      child: Text('Нет комментариев',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
    );
  }
}
