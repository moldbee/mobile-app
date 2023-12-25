import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_city/shared/helpers/translate.dart';

Future<void> translateInuts(
    GlobalKey<FormBuilderState> formKey, List<String> names) async {
  final formValues = formKey.currentState?.fields;
  // ignore: avoid_function_literals_in_foreach_calls
  names.forEach((key) async {
    final roInputKey = "${key}_ro";
    final ruInputKey = "${key}_ru";
    final roInputValue = formValues?[roInputKey]?.value;
    final ruInputValue = formValues?[ruInputKey]?.value;

    if (ruInputValue == '' && roInputValue != '') {
      return await translate(roInputValue, lang: 'ru').then((value) {
        formValues?[ruInputKey]?.didChange(value);
      });
    }

    if (roInputValue == '' && ruInputValue != '') {
      return await translate(ruInputValue, lang: 'ro').then((value) {
        formValues?[roInputKey]?.didChange(value);
      });
    }
  });
}
