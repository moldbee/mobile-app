import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/shared/config/pallete.dart';

class DateTimePickerInput extends StatelessWidget {
  const DateTimePickerInput(
      {super.key,
      required this.name,
      this.helperText,
      this.firstDate,
      this.lastDate,
      this.onCleared,
      required this.label,
      this.icon,
      this.inputType = InputType.date});

  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? helperText;
  final String name;
  final String label;
  final Widget? icon;
  final InputType inputType;
  final Function()? onCleared;

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return FormBuilderDateTimePicker(
      name: name,
      firstDate: firstDate,
      lastDate: lastDate,
      format: DateFormat('${DateFormat.WEEKDAY} dd MMMM, yyyy HH:mm', locale),
      helpText: helperText,
      locale: const Locale('ru', 'RU'),
      inputType: inputType,
      cursorColor: Colors.red,
      decoration: InputDecoration(
          suffixIcon: onCleared is Function
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onCleared,
                  child: Icon(Icons.close_rounded, color: Colors.grey.shade600),
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          icon: icon,
          iconColor: greySwatch.shade800,
          label: Text(label),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: greySwatch.shade400))),
    );
  }
}
