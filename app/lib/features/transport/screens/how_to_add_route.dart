import 'package:flutter/material.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key, required this.order, required this.content, this.child});
  final String order;
  final String content;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '$order.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class HowToAddRouteScreen extends StatelessWidget {
  const HowToAddRouteScreen({super.key});
  final route = '/transport/how-to-add-route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to add'),
      ),
      body: ScaffoldBody(
          child: ListView(
        children: const [
          ListItem(
              order: '1',
              content:
                  'Exercitation irure aliqua excepteur id amet adipisicing qui ipsum elit. Non sit veniam magna voluptate elit labore adipisicing nulla esse. Ex reprehenderit minim nostrud occaecat cillum adipisicing eu. Est consectetur commodo commodo et velit reprehenderit magna duis qui. Velit sunt nisi in amet et duis quis occaecat labore cupidatat. Consectetur aute nulla duis est cupidatat amet quis laborum ut aute laboris reprehenderit reprehenderit. Velit eiusmod Lorem cupidatat consequat veniam excepteur est adipisicing qui deserunt.'),
          ListItem(
              order: '2',
              content:
                  'Dolore excepteur ad aliqua occaecat. Reprehenderit mollit cupidatat excepteur laborum deserunt eu. Magna tempor voluptate est dolor ad excepteur duis. Consectetur pariatur cupidatat duis quis in exercitation.')
        ],
      )),
    );
  }
}
