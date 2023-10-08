import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

final iconsByStatus = {
  'info': Icons.info_rounded,
  'warning': Icons.warning_rounded,
  'discount': Icons.percent_rounded,
  'price': Icons.attach_money_rounded
};

final iconColorByStatus = {
  'info': Colors.blue,
  'warning': Colors.red,
  'discount': Colors.red,
  'price': Colors.cyan
};

class ServiceUpsert extends HookWidget {
  ServiceUpsert({Key? key}) : super(key: key);
  final String route = '/service/upsert';
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;

  @override
  Widget build(BuildContext context) {
    final pickedCategory = usePreservedState('picked-category', context);
    final pickedImage = usePreservedState('picked-service-image', context);
    final aditionalFields = usePreservedState('info-fields', context, []);
    final scrollController = useScrollController();
    final hasSelectedImage = pickedImage.value is XFile;
    final formState =
        usePreservedState('new-form-state', context, <String, dynamic>{});
    final typeOfService =
        usePreservedState('type-of-service', context, {'service'});
    return Scaffold(
      appBar: AppBar(title: const Text('Добавление услуги'), actions: [
        IconButton(
            onPressed: () async {
              final image =
                  await _imagePicker.pickImage(source: ImageSource.gallery);
              pickedImage.value = image;
            },
            icon: const Icon(Icons.attach_file_rounded)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.done))
      ]),
      body: FormBuilder(
          initialValue: formState.value,
          onChanged: () {
            _formKey.currentState?.save();
            formState.value = _formKey.currentState?.value;
          },
          key: _formKey,
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            children: [
              if (hasSelectedImage) ...[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(pickedImage.value!.path))),
                const SizedBox(height: 30),
              ],
              SegmentedButton(
                emptySelectionAllowed: false,
                selectedIcon: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    textStyle: const MaterialStatePropertyAll(
                        TextStyle(color: Colors.white)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange.shade400)),
                segments: const [
                  ButtonSegment(value: 'service', label: Text('Сервис')),
                  ButtonSegment(value: 'section', label: Text('Секция')),
                ],
                selected: typeOfService.value,
                onSelectionChanged: (value) {
                  typeOfService.value = {value.first};
                },
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'title_ro', title: 'Название (RO)'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'title_ru', title: 'Название (RU)'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'phone', title: 'Телефон'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'messageLink', title: 'Написать'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'website', title: 'Веб сайт'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'place', title: 'Местоположение'),
              SizedBox(
                height: itemsSpacing,
              ),
              DropdownSearch(
                compareFn: (item1, item2) => item1 == item2,
                selectedItem: pickedCategory.value,
                itemAsString: (item) => item.toString(),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        InputDecoration(label: Text('Категория'))),
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem != null ? selectedItem.toString() : '',
                ),
                popupProps: PopupProps.menu(
                    containerBuilder: (context, popupWidget) => Stack(
                          children: [popupWidget],
                        ),
                    showSearchBox: true,
                    menuProps: const MenuProps(),
                    searchFieldProps: const TextFieldProps(
                        decoration:
                            InputDecoration(hintText: 'Поиск по категориям')),
                    showSelectedItems: true,
                    constraints:
                        const BoxConstraints(minWidth: double.infinity)),
                filterFn: (item, query) {
                  return (item as String)
                      .toLowerCase()
                      .contains(query.toLowerCase());
                },
                onChanged: (value) => pickedCategory.value = value,
                items: const ['Main', 'Second'],
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(
                name: 'description_ro',
                title: 'Описание (RO)',
                minLines: 4,
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(
                name: 'description_ru',
                title: 'Описание (RU)',
                minLines: 4,
              ),
              if (!aditionalFields.value.isEmpty) ...[
                SizedBox(
                  height: itemsSpacing,
                ),
                ...aditionalFields.value.asMap().entries.map((field) => Padding(
                      padding: EdgeInsets.only(
                          bottom: aditionalFields.value.length > 1 ? 20 : 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              minLines: 1,
                              maxLines: double.maxFinite.toInt(),
                              decoration: InputDecoration(
                                  labelText: field.value['title'],
                                  prefixIcon: Icon(
                                    iconsByStatus[field.value['status']],
                                    color: iconColorByStatus[
                                        field.value['status']],
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              aditionalFields.value = aditionalFields.value
                                  .where((item) =>
                                      item != aditionalFields.value[field.key])
                                  .toList();
                            },
                            child: Icon(Icons.close_rounded,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    )),
              ],
              SizedBox(
                height: itemsSpacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                      onPressed: () {
                        aditionalFields.value = [
                          ...aditionalFields.value,
                          {
                            'status': 'info',
                            'title': 'Информация',
                          }
                        ];
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 80);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade400)),
                      child: const Icon(
                        Icons.info_rounded,
                        color: Colors.white,
                      )),
                  FilledButton(
                      onPressed: () {
                        aditionalFields.value = [
                          ...aditionalFields.value,
                          {
                            'status': 'warning',
                            'title': 'Предупреждение',
                          }
                        ];
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 80);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade400)),
                      child: const Icon(
                        Icons.warning_rounded,
                        color: Colors.white,
                      )),
                  FilledButton(
                      onPressed: () {
                        aditionalFields.value = [
                          ...aditionalFields.value,
                          {
                            'status': 'discount',
                            'title': 'Скидка',
                          }
                        ];
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 80);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade400)),
                      child: const Icon(
                        Icons.percent_rounded,
                        color: Colors.white,
                      )),
                  FilledButton(
                      onPressed: () {
                        aditionalFields.value = [
                          ...aditionalFields.value,
                          {
                            'status': 'price',
                            'title': 'Цены',
                          }
                        ];
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 80);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan)),
                      child: const Icon(
                        Icons.attach_money_rounded,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
