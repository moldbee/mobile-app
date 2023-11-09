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

class ServiceInfoUpsert extends HookWidget {
  const ServiceInfoUpsert({Key? key, this.serviceId, this.infoId})
      : super(key: key);
  final String route = '/service/info/upsert';
  static final _formKey = GlobalKey<FormBuilderState>();
  final String? serviceId;
  final String? infoId;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    dynamic defaultValue = {
      'description_ro': 'Reducere la produse ROGOB',
      'description_ru': 'Скидка на продукты ROGOB',
    };

    if (infoId != null) {
      final existingInfo = servicesController.infos
          .firstWhere((element) => element['id'].toString() == infoId);
      defaultValue = {
        'id': existingInfo['id'],
        'description_ru': existingInfo['description_ru'],
        'description_ro': existingInfo['description_ro'],
        'start_date': existingInfo['start_date'] != 'null'
            ? DateTime.parse(existingInfo['start_date'])
            : null,
        'end_date': existingInfo['end_date'] != 'null'
            ? DateTime.parse(existingInfo['end_date'])
            : null,
      };
    }
    final persistedFormState =
        usePreservedState('categoryFormState', context, defaultValue);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Добавление информацию'),
          actions: [
            if (infoId != null) ...[
              IconButton(
                  onPressed: () async {
                    await showDeleteConfirm(() async {
                      await supabase
                          .from('services_infos')
                          .delete()
                          .eq('id', infoId);
                      await servicesController.fetchInfos();
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
                await servicesController.upsertInfo(
                    serviceId as String,
                    formVal['description_ru'],
                    formVal['description_ro'],
                    formVal['start_date'].toString(),
                    formVal['end_date'].toString(),
                    infoId);

                await servicesController.fetchInfos();
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
