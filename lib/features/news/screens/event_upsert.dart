import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/news/events_controller.dart';
import 'package:smart_city/shared/widgets/form/date_time_picker_input.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class EventsUpsertScreen extends HookWidget {
  EventsUpsertScreen({Key? key, this.id}) : super(key: key);
  final String route = '/news/upsert/event';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final double itemsSpacing = 30;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.find<EventsController>();

    return Scaffold(
        appBar: AppBar(
          title:
              Text(id == null ? 'Создание события' : 'Редактирование события'),
          actions: [
            IconButton(
                onPressed: () {
                  if (id != null) {
                    eventsController.deleteEvent(id);
                  }
                  context.pop();
                },
                icon: const Icon(Icons.delete_rounded)),
            IconButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final data = _formKey.currentState!.value;
                    if (id != null) {
                      eventsController.updateEvent(
                          id, {...data, 'date': data['date'].toString()});
                    } else {
                      eventsController.createEvent(
                          {...data, 'date': data['date'].toString()});
                    }
                    context.pop();
                  }
                },
                icon: const Icon(
                  Icons.done_rounded,
                ))
          ],
        ),
        body: FormBuilder(
          key: _formKey,
          initialValue: id != null
              ? {
                  ...eventsController.events
                      .firstWhere((element) => element['id'].toString() == id),
                  'date': DateTime.parse(eventsController.events
                      .firstWhere(
                          (element) => element['id'].toString() == id)['date']
                      .toString())
                }
              : {
                  'date': DateTime.now(),
                  'emoji': '🇲🇩',
                  'title_ro': 'Ziua Independenței',
                  'title_ru': 'День Независимости',
                  'place_ro': 'Centru',
                  'info_url':
                      'https://balti.md/planul-activitatilor-culturale-dedicate-sarbatorii-nationale-ziua-independentei-republicii-moldova/',
                  'place_ru': 'Центральная площадь',
                  'place_url': 'https://maps.app.goo.gl/hDfRQjoWrbetTsTj6',
                },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            children: [
              const TextInput(name: 'emoji', title: 'Эмодзи'),
              SizedBox(
                height: itemsSpacing,
              ),
              const TextInput(name: 'info_url', title: 'Ссылка на информацию'),
              SizedBox(
                height: itemsSpacing,
              ),
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
                name: 'place_ru',
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
              ),
            ],
          ),
        ));
  }
}
