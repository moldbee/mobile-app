import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
  ServiceUpsert({Key? key, this.categoryId}) : super(key: key);
  final String route = '/service/upsert';
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final pickedImage = usePreservedState('picked-service-image', context);
    final aditionalFields = usePreservedState('info-fields', context, []);
    final scrollController = useScrollController();
    final hasSelectedImage = pickedImage.value is XFile;
    final formState =
        usePreservedState('new-form-state', context, <String, dynamic>{
      'title_ro': 'McDonalds',
      'title_ru': 'Макдоналдс',
      'phone': '+373 79 123 456',
      'category': categoryId,
      'messageLink': 'https://t.me/mcdonalds',
      'website': 'https://mcdonalds.md',
      'place': 'https://maps.app.goo.gl/Mgh9XZyGeHrQ7GBBA',
      'description_ro':
          'McDonald’s este cel mai mare lanț de restaurante cu servire rapidă din lume, cu peste 37.000 de restaurante în peste 100 de țări. În România, McDonald’s este prezent din anul 1995, iar în prezent are 85 de restaurante în 30 de orașe din țară.',
      'description_ru':
          'Макдоналдс — американская корпорация, крупнейшая в мире сеть ресторанов быстрого питания. Штаб-квартира — в городе Окленд, штат Калифорния. В настоящее время входит в число 100 крупнейших корпораций США по версии журнала Fortune.',
    });
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
