import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat formatter(BuildContext context) {
  final locale = Localizations.localeOf(context).languageCode;

  return DateFormat('d MMMM, yyyy', locale);
}
