import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteConfirmAlert extends StatelessWidget {
  const DeleteConfirmAlert({Key? key, required this.onDelete})
      : super(key: key);

  final dynamic onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            await onDelete();
            if (!context.mounted) return;
            context.pop(true);
            context.pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
