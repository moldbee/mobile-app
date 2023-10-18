import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class ServiceCategoryUpsert extends HookWidget {
  const ServiceCategoryUpsert({Key? key}) : super(key: key);
  final String route = '/service/category/upsert';
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final pickedIcon = usePreservedState('pickedIcon', context, 63364);
    final persistedFormState =
        usePreservedState('categoryFormState', context, <String, dynamic>{
      'title_ro': 'Mancare',
      'title_ru': 'Еда',
    });
    final servicesController = Get.find<ServicesController>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Добавление категории'),
          actions: [
            IconButton(
              icon: Icon(
                pickedIcon.value is int
                    ? IconData(pickedIcon.value, fontFamily: 'MaterialIcons')
                    : Icons.check_box_outline_blank_sharp,
                size: 30,
              ),
              onPressed: () async {
                final pickedValue = await FlutterIconPicker.showIconPicker(
                    context,
                    noResultsText: 'Ничего не найдено',
                    iconColor: Colors.grey.shade600);
                if (pickedValue != null) {
                  pickedIcon.value = pickedValue.codePoint;
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.done_rounded,
                size: 30,
              ),
              onPressed: () async {
                if (pickedIcon.value is! int) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Выберите иконку')));
                  return;
                }
                await servicesController.upsertCategory(
                    pickedIcon.value,
                    persistedFormState.value['title_ro'],
                    persistedFormState.value['title_ru']);
                await servicesController.fetchCategories();
                if (!context.mounted) return;
                context.pop();
              },
            )
          ],
        ),
        body: FormBuilder(
          key: _formKey,
          initialValue: persistedFormState.value,
          onChanged: () {
            _formKey.currentState?.save();
            persistedFormState.value = _formKey.currentState?.value;
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Column(
              children: [
                TextInput(name: 'title_ro', title: 'Название на румынском'),
                SizedBox(height: 30),
                TextInput(name: 'title_ru', title: 'Название на русском'),
              ],
            ),
          ),
        ));
  }
}
