import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/helpers/show_delete_confirm.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/date_time_picker_input.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class ServiceAlertUpsert extends HookWidget {
  const ServiceAlertUpsert({Key? key, this.serviceId, this.alertId})
      : super(key: key);
  final String route = '/service/alert/upsert';
  static final _formKey = GlobalKey<FormBuilderState>();
  final String? serviceId;
  final String? alertId;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    dynamic defaultValue = {
      'description_ro': 'Fugiti, la noi s-a spart teava',
      'description_ru': 'Бегите у нас трубу прорвало',
    };

    if (alertId != null) {
      final existingAlert = servicesController.alerts
          .firstWhere((element) => element['id'].toString() == alertId);
      defaultValue = {
        'id': existingAlert['id'],
        'description_ru': existingAlert['description_ru'],
        'description_ro': existingAlert['description_ro'],
        'start_date': existingAlert['start_date'] != 'null'
            ? DateTime.parse(existingAlert['start_date'])
            : null,
        'end_date': existingAlert['end_date'] != 'null'
            ? DateTime.parse(existingAlert['end_date'])
            : null,
      };
    }
    final persistedFormState =
        usePreservedState('categoryFormState', context, defaultValue);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Добавление предупреждения'),
          actions: [
            if (alertId != null) ...[
              IconButton(
                  onPressed: () async {
                    await showDeleteConfirm(() async {
                      await supabase
                          .from('services_alerts')
                          .delete()
                          .eq('id', alertId);
                      await servicesController.fetchAlerts();
                    }, context);
                  },
                  icon: const Icon(Icons.delete_rounded)),
            ],
            IconButton(
              icon: const Icon(
                Icons.done_rounded,
                size: 30,
              ),
              onPressed: () async {
                final formVal = persistedFormState.value;
                await servicesController.upsertAlert(
                    serviceId as String,
                    formVal['description_ru'],
                    formVal['description_ro'],
                    formVal['start_date'].toString(),
                    formVal['end_date'].toString(),
                    alertId);

                await servicesController.fetchAlerts();
                if (!context.mounted) return;
                context.pop();
              },
            )
          ],
        ),
        body: FormBuilder(
          key: _formKey,
          initialValue: persistedFormState.value,
          onChanged: () {
            _formKey.currentState?.save();
            persistedFormState.value = _formKey.currentState?.value;
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Column(
              children: [
                TextInput(
                    name: 'description_ro', title: 'Название на румынском'),
                SizedBox(height: 30),
                TextInput(name: 'description_ru', title: 'Название на русском'),
                SizedBox(height: 30),
                DateTimePickerInput(
                  name: 'start_date',
                  label: 'Начало',
                ),
                SizedBox(height: 30),
                DateTimePickerInput(
                  name: 'end_date',
                  label: 'Конец',
                ),
              ],
            ),
          ),
        ));
  }
}
