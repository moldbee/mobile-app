import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/controller.dart';
import 'package:smart_city/shared/helpers/translate_inputs.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';
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
                  translateInuts(_formKey, ['title', 'place']);
                },
                icon: const Icon(Icons.translate_rounded)),
            if (id != null) ...[
              IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) =>
                            DeleteConfirmAlert(onDelete: () async {
                              await eventsController.deleteEvent(id);
                            }));
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                  ))
            ],
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
                  'title_ro': '',
                  'title_ru': '',
                  'place_ro': '',
                  'info_url': '',
                  'place_ru': '',
                  'place_url': '',
                  'price': '',
                },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            children: [
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
              const TextInput(
                name: 'price',
                title: 'Цена',
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
