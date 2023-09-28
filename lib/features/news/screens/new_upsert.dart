import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_city/features/news/controller.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:uuid/uuid.dart';

Future<String?> uploadImage(ValueNotifier pickedImage) async {
  final image = pickedImage.value as XFile;
  final imageKeyInBucket =
      'news-${supabase.auth.currentUser!.id}-${const Uuid().v4()}';
  await supabase.storage
      .from('news')
      .upload(imageKeyInBucket, File(image.path));
  final uploadedImageFileUrl =
      supabase.storage.from('news').getPublicUrl(imageKeyInBucket);
  return uploadedImageFileUrl;
}

class NewsUpsertScreen extends HookWidget {
  NewsUpsertScreen({Key? key, this.id}) : super(key: key);
  final String route = '/news/upsert';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;
  final ImagePicker _imagePicker = ImagePicker();
  final String? id;

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();
    final editingNew = newsController.news.firstWhere(
        (element) => element['id'].toString() == id,
        orElse: () => <String, dynamic>{});
    final pickedImage =
        usePreservedState('picked-new-image', context, editingNew['image']);
    final hasSelectedImage = pickedImage.value != null;
    final isRemoteImage = pickedImage.value is String;
    void pickImage() async {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImage.value = image;
      }
    }

    final formState =
        usePreservedState('new-form-state', context, <String, dynamic>{
      'title_ro':
          'Salutare, lume! Eu sunt o știre scrisa in limba română și nu in limba rusă',
      'title_ru':
          'Привет, мир! Я новость написанная на русском языке, а не на румынском',
      'description_ro':
          'Salutare, lume! Eu sunt o știre scrisa in limba română și nu in limba rusă. Apropo am acest text este scris de Github Copilot. Nu știu ce altceva sa scriu, asa ca scriu ce scrie Github Copilot. Id aliquip nulla amet tempor minim Lorem veniam anim quis in cillum anim. Consequat et irure nisi fugiat ullamco laboris esse pariatur proident fugiat. Occaecat ea tempor eiusmod culpa aliqua exercitation aliqua nulla consequat officia dolor minim cupidatat. Irure fugiat sint nisi adipisicing non ut pariatur adipisicing irure sunt id eiusmod nulla.',
      'description_ru':
          'Привет, мир! Я новость написанная на русском языке, а не на румынском. Кстати этот текст написан Github Copilot. Я не знаю что еще написать, поэтому пишу что пишет Github Copilot. Id aliquip nulla amet tempor minim Lorem veniam anim quis in cillum anim. Consequat et irure nisi fugiat ullamco laboris esse pariatur proident fugiat. Occaecat ea tempor eiusmod culpa aliqua exercitation aliqua nulla consequat officia dolor minim cupidatat. Irure fugiat sint nisi adipisicing non ut pariatur adipisicing irure sunt id eiusmod nulla.',
    });
    final isLoading = useState(false);

    void uploadNew() async {
      try {
        isLoading.value = true;
        _formKey.currentState?.save();
        final formState = _formKey.currentState;
        if (formState != null && formState.validate()) {
          if (id != null) {
            if (pickedImage.value is XFile) {
              final uploadedImageFileUrl = await uploadImage(pickedImage);
              await newsController.updateNew(id!, {
                ...formState.value,
                'image': uploadedImageFileUrl,
              });
              if (!context.mounted) return;
              context.pop();
              return;
            }

            await newsController.updateNew(
                id!, {...formState.value, 'image': editingNew['image']});
            if (!context.mounted) return;
            context.pop();
            return;
          }

          final formValue = formState.value;
          final uploadedImageFileUrl = await uploadImage(pickedImage);
          await newsController
              .createNew({...formValue, 'image': uploadedImageFileUrl});
          if (!context.mounted) return;
          context.go(const NewsScreen().route);
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ошибка при создании новости'),
          backgroundColor: Colors.red,
        ));
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title:
              Text(id != null ? 'Редактирование новости' : 'Создание новости'),
          actions: [
            IconButton(
                onPressed: pickImage,
                icon: const Icon(Icons.attach_file_rounded)),
            IconButton(
                onPressed: () {
                  if (pickedImage.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Пожалуйста, выберите изображение'),
                      backgroundColor: Colors.red,
                    ));

                    return;
                  }

                  uploadNew();
                },
                disabledColor: Colors.grey,
                icon: const Icon(
                  Icons.done_rounded,
                ))
          ],
        ),
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
                  GestureDetector(
                    onTap: pickImage,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: id != null && isRemoteImage
                            ? Image.network(editingNew['image'])
                            : Image.file(File(pickedImage.value!.path))),
                  ),
                  const SizedBox(height: 30),
                ],
                TextInput(
                    name: 'title_ro',
                    title: 'Заголовок (RO)',
                    validators: [
                      FormBuilderValidators.required(),
                    ]),
                SizedBox(
                  height: itemsSpacing,
                ),
                TextInput(
                    name: 'title_ru',
                    title: 'Заголовок (RU)',
                    validators: [
                      FormBuilderValidators.required(),
                    ]),
                SizedBox(
                  height: itemsSpacing,
                ),
                const TextInput(
                  name: 'subtitle_ro',
                  title: 'Подзаголовок (RO)',
                ),
                SizedBox(
                  height: itemsSpacing,
                ),
                const TextInput(
                  name: 'subtitle_ru',
                  title: 'Подзаголовок (RU)',
                ),
                SizedBox(
                  height: itemsSpacing,
                ),
                TextInput(
                    name: 'description_ro',
                    title: 'Описание (RO)',
                    minLines: 4,
                    validators: [
                      FormBuilderValidators.required(),
                    ]),
                SizedBox(
                  height: itemsSpacing,
                ),
                TextInput(
                    name: 'description_ru',
                    title: 'Описание (RU)',
                    minLines: 4,
                    validators: [
                      FormBuilderValidators.required(),
                    ]),
              ],
            )));
  }
}
