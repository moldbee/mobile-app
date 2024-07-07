import 'package:flutter/material.dart';
import 'package:smart_city/features/transport/widgets/ticket_card.dart';
import 'package:smart_city/l10n/main.dart';

final items = [1, 2, 3, 4, 5, 6, 7, 8, 9];

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});
  final route = '/transport/routes';

  @override
  Widget build(BuildContext context) {
    final loc = getAppLoc(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.routes),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: items.length,
          itemBuilder: (context, index) => const RouteTicketCard(),
          separatorBuilder: (context, index) => const Divider(
                height: 30,
              )),
    );
  }
}
