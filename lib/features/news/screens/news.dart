import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/screens/events.dart';
import 'package:smart_city/features/news/widgets/news_body.dart';
import 'package:smart_city/l10n/main.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({Key? key}) : super(key: key);
  final String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppLoc(context)!.news),
      ),
      body: const NewsScreenContentBody(),
    );
  }
}
