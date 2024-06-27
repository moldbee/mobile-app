import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/l10n/main.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final todayDate = DateTime.now();
    final textInputController = TextEditingController();
    final loc = getAppLoc(context);

    return TextField(
      showCursor: false,
      controller: textInputController,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
          hintText: loc!.dateAndTime,
          prefixIcon: const Icon(Icons.date_range_rounded)),
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            firstDate: todayDate,
            initialDate: todayDate,
            lastDate:
                DateTime(todayDate.year + 1, todayDate.month, todayDate.day));

        if (!context.mounted || date == null) return;

        final time = await showTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 00, minute: 00));

        if (!context.mounted || time == null) return;

        final dateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);

        final formattedDateTime = DateFormat(
                'dd MMMM, HH:mm, yyyy • EEEE',
                // ignore: use_build_context_synchronously
                Localizations.localeOf(context).languageCode)
            .format(dateTime);
        controller.value = TextEditingValue(text: dateTime.toString());

        textInputController.value = TextEditingValue(text: formattedDateTime);
      },
    );
  }
}
