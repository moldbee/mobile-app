import 'package:flutter/material.dart';

class ContentBlock extends StatelessWidget {
  const ContentBlock(
      {super.key,
      required this.child,
      this.enableTopDivider,
      required this.title});

  final Widget child;
  final bool? enableTopDivider;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // if (enableTopDivider ?? false) divider,
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800),
          ),
        ),
        // divider,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: child,
        ),
        // divider,
      ],
    );
  }
}
