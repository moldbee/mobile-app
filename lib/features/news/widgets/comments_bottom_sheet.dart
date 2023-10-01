import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:smart_city/features/news/screens/details.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class CommentsBottomSheet extends HookWidget {
  const CommentsBottomSheet(
      {Key? key, this.newId, this.comments, this.setComments})
      : super(key: key);
  static final _formKey = GlobalKey<FormBuilderState>();

  final String? newId;
  final dynamic comments;
  final Function(dynamic value)? setComments;

  @override
  Widget build(BuildContext context) {
    final selectedForReplyComment = useState<String?>(null);
    final ProfileController profileController = Get.find<ProfileController>();
    final formState =
        usePreservedState('comment-form-state', context, {'comment': ''});

    useEffect(() {
      Timer timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (newId != null) {
          setComments!(await fetchCommentsForNew(newId));
        }
      });
      return () {
        timer.cancel();
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
              if (comments!.isNotEmpty)
                for (var comment in comments)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Comment(
                      setComments: setComments!,
                      newId: newId!,
                      id: comment['id'].toString(),
                      nick: comment['created_by']['nick'],
                      avatar: comment['created_by']['avatar'],
                      createdAt: comment['created_at'],
                      likes: comment['likes'].toString(),
                      replyCommentId: comment['reply_comment_id'],
                      message: comment['message'],
                      onReply: (id) {
                        selectedForReplyComment.value = id;
                      },
                    ),
                  )
              else
                const NoCommentsMessage()
            ]),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: .5, color: Colors.grey.shade400))),
          child: Row(
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
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: GestureDetector(
                  child: IconButton(
                      onPressed: () async {
                        print(formState.value);
                        if (_formKey.currentState!.value['comment']?.length <
                            5) {
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
                            'created_by':
                                int.parse(profileController.id.value as String)
                          };

                          if (selectedForReplyComment.value != null) {
                            comment['reply_comment_id'] =
                                selectedForReplyComment.value;
                          }
                          await supabase.from('news_comments').insert(comment);
                          setComments!(await fetchCommentsForNew(newId));
                          _formKey.currentState!.reset();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.grey.shade400,
                      )),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class Comment extends HookWidget {
  const Comment({
    super.key,
    required this.onReply,
    required this.message,
    required this.likes,
    required this.id,
    required this.nick,
    required this.newId,
    required this.setComments,
    required this.avatar,
    required this.createdAt,
    this.replyCommentId,
  });

  final Function(String id) onReply;
  final String message;
  final String likes;
  final Function setComments;
  final String id;
  final String nick;
  final String newId;
  final String avatar;
  final String createdAt;
  final String? replyCommentId;

  @override
  Widget build(BuildContext context) {
    final isLiked = useState(false);
    final profileController = Get.find<ProfileController>();

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
                    backgroundImage: NetworkImage(avatar),
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
                onTap: () {
                  isLiked.value = !isLiked.value;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        likes,
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    onReply('132321312');
                  },
                  child: Text(
                    'Ответить',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Пожаловаться',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                if (nick == profileController.nick.value) ...[
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        print('Hello word');
                        showDialog(
                            context: context,
                            builder: (context) => DeleteConfirmAlert(
                                disableDoublePop: true,
                                onDelete: () async {
                                  await supabase
                                      .from('news_comments')
                                      .delete()
                                      .eq('id', id);
                                  setComments(await fetchCommentsForNew(newId));
                                }));
                      },
                      child: Text('Удалить',
                          style: TextStyle(color: Colors.grey.shade600))),
                ]
              ],
            ),
          )
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
