import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_city/shared/widgets/form/date_time_picker_input.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class EventsUpsertScreen extends HookWidget {
  EventsUpsertScreen({Key? key}) : super(key: key);
  final String route = '/news/upsert/event';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Создание события'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.done_rounded,
                ))
          ],
        ),
        body: FormBuilder(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            children: [
              const TextInput(name: 'title_ro', title: 'Заголовок (RO)'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'title_ru', title: 'Заголовок (RU)'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(
                name: 'place_ro',
                title: 'Место (RO)',
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(
                name: 'place',
                title: 'Место (RU)',
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(
                name: 'place_url',
                title: 'Ссылка гугл карт на место',
              ),
              SizedBox(
                height: itemsSpacing,
              ),
              const DateTimePickerInput(
                name: 'date',
                label: 'Дата и время',
                inputType: InputType.both,
              )
            ],
          ),
        ));
  }
}
