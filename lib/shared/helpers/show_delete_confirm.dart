import 'package:flutter/material.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';

Future<void> showDeleteConfirm(Function onDelete, BuildContext context,
    {bool disableDoublePop = false}) async {
  await showDialog(
      context: context,
      builder: (context) => DeleteConfirmAlert(
            onDelete: onDelete,
            disableDoublePop: disableDoublePop,
          ));
}
