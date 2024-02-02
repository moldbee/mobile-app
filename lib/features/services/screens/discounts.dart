import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({Key? key}) : super(key: key);
  final route = '/services/disounts';

  @override
  Widget build(BuildContext context) {
    final localiz = getAppLoc(context);

    return Scaffold(
      appBar: AppBar(title: Text(localiz!.promotions)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction_rounded),
            const SizedBox(
              width: 10,
            ),
            Text(localiz.in_development),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.construction_rounded),
          ],
        ),
      ),
    );
  }
}
