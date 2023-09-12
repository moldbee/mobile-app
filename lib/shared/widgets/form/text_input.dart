import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TextInput extends HookWidget {
  const TextInput(
      {Key? key,
      required this.name,
      required this.title,
      this.validators = const [],
      this.icon,
      this.maxLines,
      this.hintText = '',
      this.suffix,
      this.isPassword = false,
      this.minLines})
      : super(key: key);

  final String title;
  final String name;
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final Widget? icon;
  final Widget? suffix;
  final bool isPassword;
  final List<String? Function(String?)> validators;

  @override
  Widget build(BuildContext context) {
    final showPassword = useState(false);
    return FormBuilderTextField(
      name: name,
      obscureText: isPassword ? !showPassword.value : false,
      enableSuggestions: isPassword ? false : true,
      autocorrect: isPassword ? false : true,
      minLines: minLines,
      maxLines: isPassword ? 1 : maxLines,
      validator: FormBuilderValidators.compose(validators),
      decoration: InputDecoration(
          hintText: hintText,
          suffix: suffix,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    showPassword.value
                        ? showPassword.value = false
                        : showPassword.value = true;
                  },
                  icon: Icon(
                    showPassword.value
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Colors.grey.shade400,
                  ))
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          iconColor: Colors.grey.shade800,
          icon: icon,
          label: Text(title),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400))),
    );
  }
}
