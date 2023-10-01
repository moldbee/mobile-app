import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteConfirmAlert extends StatelessWidget {
  const DeleteConfirmAlert(
      {Key? key, required this.onDelete, this.disableDoublePop = false})
      : super(key: key);

  final bool disableDoublePop;
  final dynamic onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удаление'),
      content: const Text('Вы уверены что хотите удалить?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text('Нет', style: TextStyle(color: Colors.grey.shade600)),
        ),
        TextButton(
          onPressed: () async {
            await onDelete();
            if (!context.mounted) return;
            context.pop(true);
            if (!disableDoublePop) {
              context.pop();
            }
          },
          child: const Text('Да', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
