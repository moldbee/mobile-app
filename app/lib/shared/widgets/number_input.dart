import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NumberInput extends HookWidget {
  const NumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: '0');

    return TextField(
      enableInteractiveSelection: false,
      readOnly: true,
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
          prefixIconColor: Colors.grey.shade500,
          suffixIconColor: Colors.grey.shade500,
          prefixIcon: IconButton(
              onPressed: () {
                controller.value = TextEditingValue(
                    text: (toInt(controller.text)! + 1).toString());
              },
              icon: const Icon(Icons.keyboard_arrow_up_rounded)),
          suffixIcon: IconButton(
            onPressed: () {
              controller.value = TextEditingValue(
                  text: (toInt(controller.text)! - 1).toString());
            },
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          )),
    );
  }
}
