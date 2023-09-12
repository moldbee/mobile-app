import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class NewsUpsertScreen extends HookWidget {
  NewsUpsertScreen({Key? key}) : super(key: key);
  final String route = '/news/upsert/new';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final pickedImage = usePreservedState('picked-new-image', context);
    final hasSelectedImage = pickedImage.value is XFile;
    final formState =
        usePreservedState('new-form-state', context, <String, dynamic>{});

    return Scaffold(
        appBar: AppBar(
          title: const Text('Создание новости'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.done_rounded,
                  color: Colors.orange.shade400,
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
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                          onPressed: () async {
                            final image = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            pickedImage.value = image;
                          },
                          child: const Text(
                            'Выбрать основную картинку',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    if (hasSelectedImage) ...[
                      IconButton(
                          onPressed: () {
                            pickedImage.value = null;
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            color: Colors.grey.shade400,
                          ))
                    ]
                  ],
                ),
                if (hasSelectedImage) ...[
                  const SizedBox(height: 20),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(pickedImage.value!.path))),
                ],
                SizedBox(height: itemsSpacing),
                const TextInput(name: 'title', title: 'Заголовок'),
                SizedBox(
                  height: itemsSpacing,
                ),
                const TextInput(
                  name: 'subtitle',
                  title: 'Подзаголовок',
                ),
                SizedBox(
                  height: itemsSpacing,
                ),
                const TextInput(
                  name: 'description',
                  title: 'Описание',
                  minLines: 4,
                ),
              ],
            )));
  }
}
