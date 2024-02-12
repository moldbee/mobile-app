import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/widgets/comment.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/sign_in.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class CommentsBottomSheet extends HookWidget {
  const CommentsBottomSheet({Key? key, this.newId, required this.setState})
      : super(key: key);
  static final _formKey = GlobalKey<FormBuilderState>();

  final String? newId;
  final void Function(void Function()) setState;

  @override
  Widget build(BuildContext context) {
    final selectedForReplyComment =
        usePreservedState('selected-comment-reply', context, null);
    final profileController = Get.find<ProfileController>();
    final formState =
        usePreservedState('news-comment-state', context, {'comment': ''});
    final commentIdForEdit = usePreservedState('comment-id-for-edit', context);

    return FutureBuilder(
        future: supabase
            .from('news_comments')
            .select('*, created_by(nick, avatar, id)')
            .eq('new_id', newId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final comments = snapshot.data;

            void onCommentEdit(String id) {
              commentIdForEdit.value = id;
              final selectedForEditComment = comments!
                  .firstWhere((element) => element['id'].toString() == id);
              _formKey.currentState
                  ?.patchValue({'comment': selectedForEditComment['message']});
              selectedForReplyComment.value =
                  selectedForEditComment['reply_comment_id'] is int
                      ? selectedForEditComment['reply_comment_id'].toString()
                      : null;
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: .5, color: Colors.grey.shade300))),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getAppLoc(context)!.comments,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          if (comments!.isNotEmpty) ...[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Comment(
                                      setState: setState,
                                      onEdit: onCommentEdit,
                                      comments: comments,
                                      setSelectedForReplyComment: (id) {
                                        selectedForReplyComment.value = id;
                                      },
                                      newId: newId!,
                                      id: comment['id'].toString(),
                                      nick: comment['created_by']['nick'],
                                      authorId: comment['created_by']['id']
                                          .toString(),
                                      avatar: comment['created_by']['avatar'],
                                      createdAt: comment['created_at'],
                                      replyCommentId:
                                          comment['reply_comment_id'],
                                      message: comment['message'],
                                      onReply: (id) {
                                        selectedForReplyComment.value = id;
                                      },
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
                              top: BorderSide(
                                  width: .5, color: Colors.grey.shade300)),
                        ),
                        child: () {
                          final comment = comments.firstWhere((element) =>
                              element['id'].toString() ==
                              selectedForReplyComment.value.toString());
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                          comment['created_by']['avatar'] ??
                                              defaultAvatar),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment['created_by']['nick'],
                                          ),
                                          Text(
                                            comment['message'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
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
                                top: BorderSide(
                                    width: .5, color: Colors.grey.shade400))),
                        child: profileController.id.value is String
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FormBuilder(
                                    initialValue: const {'comment': ''},
                                    key: _formKey,
                                    onChanged: () {
                                      _formKey.currentState?.save();
                                      formState.value =
                                          _formKey.currentState?.value;
                                    },
                                    child: Expanded(
                                      child: TextInput(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 0, 20, 19),
                                        disableBorders: true,
                                        name: 'comment',
                                        minLines: 1,
                                        maxLines: 5,
                                        hintText:
                                            getAppLoc(context)!.inputComment,
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
                                            selectedForReplyComment.value =
                                                null;
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
                                          if (_formKey.currentState!
                                                  .value['comment']?.length <
                                              2) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              content: Text(getAppLoc(context)!
                                                  .fieldMinLength(5)),
                                              backgroundColor: Colors.red,
                                            ));
                                            return;
                                          }
                                          if (_formKey.currentState!
                                              .saveAndValidate()) {
                                            dynamic comment = {
                                              'new_id': newId,
                                              'message':
                                                  formState.value['comment'],
                                              'created_by': int.parse(
                                                  profileController.id.value
                                                      as String)
                                            };
                                            if (commentIdForEdit.value !=
                                                null) {
                                              comment['id'] =
                                                  commentIdForEdit.value;
                                            }

                                            comment['reply_comment_id'] =
                                                selectedForReplyComment.value;
                                            await supabase
                                                .from('news_comments')
                                                .upsert(comment);
                                            _formKey.currentState!.reset();
                                            selectedForReplyComment.value =
                                                null;
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
                                            getAppLoc(context)!.toLeaveComment,
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14)),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                  ]),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
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
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              color: Colors.grey.shade500)),
    );
  }
}
