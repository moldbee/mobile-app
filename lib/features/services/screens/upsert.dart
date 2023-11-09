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
      'title_ro': '',
      'title_ru': '',
      'phone': '',
      'category': categoryId,
      'message': '',
      'website': '',
      'place': '',
      'description_ro': '',
      'description_ru': '',
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
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(
                name: 'description_ru',
                title: 'Описание (RU)',
              ),
            ],
          )),
    );
  }
}
