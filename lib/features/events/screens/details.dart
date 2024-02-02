import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({Key? key, required this.id}) : super(key: key);
  final route = '/events/details';

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали события'),
      ),
      body: const Column(),
    );
  }
}
