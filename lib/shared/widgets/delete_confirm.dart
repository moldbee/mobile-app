import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/l10n/main.dart';

class DeleteConfirmAlert extends StatelessWidget {
  const DeleteConfirmAlert(
      {Key? key,
      required this.onDelete,
      this.text,
      this.disableDoublePop = false})
      : super(key: key);

  final bool disableDoublePop;
  final String? text;
  final dynamic onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getAppLoc(context)!.deleting),
      content: Text(text ?? 'Вы уверены, что хотите удалить?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(getAppLoc(context)!.no,
              style: TextStyle(color: Colors.grey.shade600)),
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
          child: Text(getAppLoc(context)!.yes,
              style: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
