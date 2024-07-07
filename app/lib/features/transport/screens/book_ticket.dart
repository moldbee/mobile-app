import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BookTicketScreen extends HookWidget {
  const BookTicketScreen({super.key});
  final route = '/transport/book/ticket';

  @override
  Widget build(BuildContext context) {
    final fullName = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: fullName,
                      decoration: const InputDecoration(hintText: 'Full name'),
                    ),
                  ),
                  TextField(
                    controller: fullName,
                    decoration: const InputDecoration(hintText: 'Full name'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
