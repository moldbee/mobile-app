import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:uuid/uuid.dart';

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
    final serviceInfos = usePreservedState('info-fields', context, []);
    final servicesController = Get.find<ServicesController>();
    final serviceInfosLastLength = usePreservedState(
        'info-fields-last-length', context, serviceInfos.value.length);
    final scrollController = useScrollController();
    final hasSelectedImage = pickedImage.value is XFile;
    final formState =
        usePreservedState('new-form-state', context, <String, dynamic>{
      'title_ro': 'McDonalds',
      'title_ru': 'Макдоналдс',
      'phone': '+373 79 123 456',
      'category': categoryId,
      'message': 'https://t.me/mcdonalds',
      'website': 'https://mcdonalds.md',
      'place': 'https://maps.app.goo.gl/Mgh9XZyGeHrQ7GBBA',
      'description_ro':
          'McDonald’s este cel mai mare lanț de restaurante cu servire rapidă din lume, cu peste 37.000 de restaurante în peste 100 de țări. În România, McDonald’s este prezent din anul 1995, iar în prezent are 85 de restaurante în 30 de orașe din țară.',
      'description_ru':
          'Макдоналдс — американская корпорация, крупнейшая в мире сеть ресторанов быстрого питания. Штаб-квартира — в городе Окленд, штат Калифорния. В настоящее время входит в число 100 крупнейших корпораций США по версии журнала Fortune.',
    });

    useEffect(() {
      if (serviceInfos.value.length > serviceInfosLastLength.value) {
        Timer(const Duration(milliseconds: 300), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        });
      }

      return null;
    }, [serviceInfos.value]);

    return Scaffold(
      appBar: AppBar(title: const Text('Добавление услуги'), actions: [
        IconButton(
            onPressed: () async {
              final image =
                  await _imagePicker.pickImage(source: ImageSource.gallery);
              pickedImage.value = image;
            },
            icon: const Icon(Icons.attach_file_rounded)),
        IconButton(
            onPressed: () async {
              try {
                dynamic uploadedAvatarFileUrl;

                if (hasSelectedImage) {
                  try {
                    final logoKeyInBucket = 'logo-${const Uuid().v4()}';
                    await supabase.storage
                        .from('services')
                        .upload(logoKeyInBucket, File(pickedImage.value!.path));
                    uploadedAvatarFileUrl = supabase.storage
                        .from('services')
                        .getPublicUrl(logoKeyInBucket);
                  } catch (error) {
                    printError(info: error.toString());
                  }
                }
                final upsertedItem = await supabase.from('services').insert({
                  ...formState.value,
                  'logo': uploadedAvatarFileUrl,  
                  'category': categoryId,
                }).select();

                await supabase.from('services_infos').insert(serviceInfos.value
                    .map((item) => {
                          'title_ru': item['title_ru'],
                          'title_ro': item['title_ro'],
                          'type': item['type'],
                          'service': upsertedItem.first['id'],
                        })
                    .toList());
                await servicesController.fetchServices();
                if (!context.mounted) return;
                context.pop();
              } catch (e) {
                printError(info: e.toString());
              }
            },
            icon: const Icon(Icons.done))
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
              const TextInput(name: 'message', title: 'Написать'),
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
              if (!serviceInfos.value.isEmpty) ...[
                SizedBox(
                  height: itemsSpacing,
                ),
                ...serviceInfos.value.asMap().entries.map((field) {
                  final inputController = TextEditingController();
                  inputController.value = const TextEditingValue(
                      text: 'Deserunt minim id reprehenderit fugiat.');

                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: serviceInfos.value.length > 1 ? 30 : 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: inputController,
                                minLines: 1,
                                onChanged: (value) {
                                  serviceInfos.value[field.key]['title_ro'] =
                                      value;
                                },
                                maxLines: double.maxFinite.toInt(),
                                decoration: InputDecoration(
                                    labelText: field.value['label'] + ' (RO)',
                                    prefixIcon: Icon(
                                      iconsByStatus[field.value['type']],
                                      color: iconColorByStatus[
                                          field.value['type']],
                                    )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: inputController,
                                minLines: 1,
                                onChanged: (value) {
                                  serviceInfos.value[field.key]['title_ru'] =
                                      value;
                                },
                                maxLines: double.maxFinite.toInt(),
                                decoration: InputDecoration(
                                    labelText: field.value['label'] + ' (RU)',
                                    prefixIcon: Icon(
                                      iconsByStatus[field.value['type']],
                                      color: iconColorByStatus[
                                          field.value['type']],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            serviceInfos.value = serviceInfos.value
                                .where((item) =>
                                    item != serviceInfos.value[field.key])
                                .toList();
                          },
                          child: Icon(Icons.close_rounded,
                              color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  );
                }),
              ],
              SizedBox(
                height: itemsSpacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                      onPressed: () {
                        serviceInfos.value = [
                          ...serviceInfos.value,
                          {
                            'id': const Uuid().v4(),
                            'type': 'info',
                            'label': 'Информация',
                          }
                        ];
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
                        serviceInfos.value = [
                          ...serviceInfos.value,
                          {
                            'type': 'warning',
                            'label': 'Предупреждение',
                          }
                        ];
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
                        serviceInfos.value = [
                          ...serviceInfos.value,
                          {
                            'type': 'discount',
                            'label': 'Скидка',
                          }
                        ];
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
                        serviceInfos.value = [
                          ...serviceInfos.value,
                          {
                            'type': 'price',
                            'label': 'Цены',
                          }
                        ];
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
