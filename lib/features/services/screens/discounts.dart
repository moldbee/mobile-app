import 'package:flutter/material.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({Key? key}) : super(key: key);
  final route = '/services/disounts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discounts')),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded),
            SizedBox(
              width: 10,
            ),
            Text('Is in development')
          ],
        ),
      ),
    );
  }
}
