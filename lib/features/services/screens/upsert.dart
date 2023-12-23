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
  ServiceUpsert({Key? key, this.categoryId, this.serviceId}) : super(key: key);
  final String route = '/service/upsert';
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;
  final String? categoryId;
  final String? serviceId;

  @override
  Widget build(BuildContext context) {
    dynamic defaultValue = {
      'title_ro': '',
      'title_ru': '',
      'phone': '',
      'category': categoryId,
      'message': '',
      'website': '',
      'place': '',
      'description_ro': '',
      'description_ru': '',
    };
    final servicesController = Get.find<ServicesController>();
    final existingService = servicesController.services
        .firstWhereOrNull((element) => element['id'].toString() == serviceId);
    final pickedImage = usePreservedState('picked-service-image', context);
    final hasSelectedImage = pickedImage.value != null;
    if (serviceId != null) {
      pickedImage.value = existingService['logo'];
      defaultValue = {
        'id': existingService['id'],
        'title_ro': existingService['title_ro'],
        'title_ru': existingService['title_ru'],
        'phone': existingService['phone'],
        'category': categoryId,
        'message': existingService['message'],
        'website': existingService['website'],
        'place': existingService['place'],
        'description_ro': existingService['description_ro'],
        'description_ru': existingService['description_ru'],
      };
    }
    final formState =
        usePreservedState('new-form-state', context, defaultValue);

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
                await supabase.from('services').upsert({
                  ...formState.value,
                  'logo': uploadedAvatarFileUrl,
                  'category': categoryId,
                }).select();

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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            children: [
              if (hasSelectedImage) ...[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: serviceId != null && pickedImage.value is String
                        ? Image.network(pickedImage.value)
                        : Image.file(File(pickedImage.value?.path))),
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
