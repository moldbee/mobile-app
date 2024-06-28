import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends HookWidget {
  const DateTimePicker({super.key, required this.controller, this.hint = ''});
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final todayDate = DateTime.now();
    final textInputController = useTextEditingController();

    return TextField(
      showCursor: false,
      controller: textInputController,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
          hintText: hint, prefixIcon: const Icon(Icons.date_range_rounded)),
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            firstDate: todayDate,
            initialDate: todayDate,
            lastDate:
                DateTime(todayDate.year + 1, todayDate.month, todayDate.day));

        if (!context.mounted || date == null) return;

        final dateTime = DateTime(date.year, date.month, date.day);

        final formattedDateTime = DateFormat(
                'dd MMMM, yyyy • EEEE',
                // ignore: use_build_context_synchronously
                Localizations.localeOf(context).languageCode)
            .format(dateTime);
        controller.value = TextEditingValue(text: dateTime.toString());

        textInputController.value = TextEditingValue(text: formattedDateTime);
      },
    );
  }
}
