import 'package:flutter/material.dart';

class ContentBlock extends StatelessWidget {
  const ContentBlock({Key? key, required this.child, this.enableTopDivider, required this.title})
      : super(key: key);

  final Widget child;
  final bool? enableTopDivider;
  final String title;

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade300,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (enableTopDivider ?? false) divider,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600),
          ),
        ),
        divider,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: child,
        ),
        divider,
      ],
    );
  }
}
