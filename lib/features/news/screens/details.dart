import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/screens/new_upsert.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({Key? key}) : super(key: key);
  final String route = '/news/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('Статья'),
        actions: [
          IconButton(
              onPressed: () {
                context.push(NewsUpsertScreen().route);
              },
              icon: const Icon(
                Icons.edit_rounded,
                size: 26,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share_rounded,
                size: 26,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/new_image.jpg'),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          size: 22,
                          color: Colors.grey.shade300,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '2503',
                            style: TextStyle(color: Colors.grey.shade400),
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
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '28',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 14, 10, 10),
                child: Text(
                  'Amet et ut cillum et culpa.',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  'Commodo cupidatat fugiat veniam sint sunt. Fugiat occaecat incididunt velit ut. Pariatur nisi ipsum minim eiusmod reprehenderit aliqua nulla. Elit mollit officia culpa dolore irure dolore cillum mollit velit ipsum quis. Esse ut aute occaecat magna sit tempor elit ad nisi ut sunt. Deserunt irure laboris proident pariatur exercitation aliquip qui nostrud cupidatat voluptate aliqua excepteur incididunt excepteur. Deserunt ad occaecat exercitation enim aliqua. Dolore nulla ex irure nostrud minim nostrud ad.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18))),
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100 *
                                                70,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: .5,
                                                            color: Colors.grey
                                                                .shade300))),
                                                height: 50,
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Комментарии',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Comment(),
                                                      Comment(),
                                                      Comment(),
                                                      Comment(),
                                                      Comment(),
                                                      Comment(),
                                                      Comment(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                            width: .5,
                                                            color: Colors.grey
                                                                .shade300))),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Expanded(
                                                      child: TextInput(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                20, 0, 20, 20),
                                                        disableBorders: true,
                                                        name: 'comment',
                                                        minLines: 1,
                                                        maxLines: 5,
                                                        hintText:
                                                            'Введите комментарий',
                                                        title: '',
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 6),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.send,
                                                            color: Colors
                                                                .grey.shade400,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      );
                                    });
                                  });
                            },
                            child: const Text('Комментарии'))),
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

class Comment extends StatelessWidget {
  const Comment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
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
                                  'Lindsey Won',
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
                                  '10 минут назад',
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      '13',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.thumb_up_rounded,
                    color: Colors.grey.shade400,
                  ),
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Magna ullamco enim aliquip consectetur do. Commodo laborum duis do consequat qui enim aliqua eiusmod culpa aliquip pariatur consequat nisi. Ad sunt cupidatat anim culpa qui irure exercitation pariatur sint deserunt.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
