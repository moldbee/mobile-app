import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smart_city/features/news/controller.dart';
import 'package:smart_city/features/news/widgets/comment.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

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

    final commentScrollController = ItemScrollController();

    final highlightIndex = comments
        ?.indexWhere((element) => element['id'].toString() == highlightId);

    useEffect(() {
      if (commentScrollController.isAttached) {
        commentScrollController.jumpTo(
          index: highlightIndex!,
        );
      }
      final highlightTimer =
          Timer.periodic(const Duration(milliseconds: 300), (timer) async {
        if (highlightId != null) {
          highlightCount.value = highlightCount.value + 1;
        }
      });
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getAppLoc(context)!.comments,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
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
                            authorId: comment['created_by']['id'].toString(),
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
                        child: Expanded(
                          child: TextInput(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 0, 20, 19),
                            disableBorders: true,
                            name: 'comment',
                            minLines: 1,
                            maxLines: 5,
                            hintText: getAppLoc(context)!.inputComment,
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
                                    .showSnackBar(SnackBar(
                                  showCloseIcon: true,
                                  content: Text(
                                      getAppLoc(context)!.fieldMinLength(5)),
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
                            child: Text(getAppLoc(context)!.toLeaveComment,
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

class NoCommentsMessage extends StatelessWidget {
  const NoCommentsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 100 * 30),
      child: Text(getAppLoc(context)!.noCommentsForNews,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
    );
  }
}
