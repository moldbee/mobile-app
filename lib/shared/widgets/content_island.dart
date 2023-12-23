import 'package:flutter/material.dart';
import 'package:smart_city/shared/config/theme.dart';

enum ContentIslandSize { sm, md, lg }

final Map<dynamic, List<double>> sizes = {
  ContentIslandSize.sm: [20, 10],
  ContentIslandSize.md: [20, 20],
  ContentIslandSize.lg: [20, 30],
};

class ContentIsland extends StatelessWidget {
  const ContentIsland(
      {Key? key,
      required this.children,
      this.title,
      this.disablePadding = false,
      this.hideWhen = false,
      this.actionIcon,
      this.size = ContentIslandSize.md})
      : super(key: key);

  final ContentIslandSize size;
  final List<Widget> children;
  final String? title;
  final bool hideWhen;
  final bool disablePadding;
  final Widget? actionIcon;

  @override
  Widget build(BuildContext context) {
    if (hideWhen) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: disablePadding ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title is String) ...[
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'dwadwad' as String,
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .fontSize),
                    ),
                    if (actionIcon is Widget) ...[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: actionIcon as Widget,
                      )
                    ]
                  ],
                )),
          ],
          Container(
            margin: EdgeInsets.only(
                top: title is! String && disablePadding ? 0 : 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            padding: EdgeInsets.symmetric(
                horizontal: sizes[size]![1], vertical: sizes[size]![0]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
