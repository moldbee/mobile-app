import 'package:flutter/material.dart';

class EmergenciesScreen extends StatelessWidget {
  const EmergenciesScreen({Key? key}) : super(key: key);
  final route = '/emergencies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экстренные службы'),
      ),
      body: const Center(
        child: Text('Экстренные службы'),
      ),
    );
  }
}
