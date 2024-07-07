import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BookTicketScreen extends HookWidget {
  const BookTicketScreen({super.key});
  final route = '/transport/book/ticket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: const Column(
        children: [
          ListTile(
            title: Text('Hello world'),
            leading: Icon(Icons.abc),
            subtitle: TextField(),
          )
        ],
      ),
    );
  }
}
