import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';

class NoContent extends StatelessWidget {
  const NoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localize = getAppLoc(context);

    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 20,
        children: [
          Icon(
            Icons.emoji_nature_rounded,
            size: 40,
            color: Colors.orange.shade200,
          ),
          Text(
            localize!.no_content,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
