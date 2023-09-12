import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_city/shared/config/pallete.dart';

class SliderInput extends StatelessWidget {
  const SliderInput(
      {super.key,
      required this.min,
      required this.max,
      required this.name,
      required this.divisions,
      required this.initialValue,
      required this.label,
      this.icon});

  final double min;
  final double max;
  final double initialValue;
  final int divisions;
  final String name;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return FormBuilderSlider(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
          iconColor: greySwatch.shade800,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: greySwatch.shade400)),
          label: Text(label),
          icon: icon),
      name: name,
      initialValue: initialValue,
      maxValueWidget: (value) => Text(
        value,
        style: TextStyle(color: greySwatch.shade500),
      ),
      minValueWidget: (value) => Text(
        value,
        style: TextStyle(color: greySwatch.shade500),
      ),
      min: min,
      max: max,
      divisions: divisions,
    );
  }
}
