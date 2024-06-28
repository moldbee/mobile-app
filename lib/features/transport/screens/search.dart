import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chisinau - Bucharest',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 5,
              children: [
                Icon(
                  Icons.timelapse_sharp,
                  color: Colors.grey.shade400,
                ),
                Text(
                  '10h',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 5,
              children: [
                Icon(
                  Icons.wifi_rounded,
                  color: Colors.grey.shade400,
                ),
                Icon(
                  Icons.wc_rounded,
                  color: Colors.grey.shade400,
                ),
                Icon(
                  Icons.air_rounded,
                  color: Colors.grey.shade400,
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text('500 MDL',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      )),
            )
          ],
        )
      ],
    );
  }
}

final items = [1, 2, 3, 4, 5];

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
      body: ScaffoldBody(
        child: ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) => const RouteCard(),
            separatorBuilder: (context, index) => const Divider(
                  height: 40,
                )),
      ),
    );
  }
}
