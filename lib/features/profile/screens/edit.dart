import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class ProfileEdit extends HookWidget {
  const ProfileEdit({Key? key, this.serviceId, this.discountId})
      : super(key: key);
  final String route = '/profile/edit';
  static final _formKey = GlobalKey<FormBuilderState>();
  final String? serviceId;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    final rofileController = Get.find<ProfileController>();
    dynamic defaultValue = {
      'nick': rofileController.nick.value,
    };

    final persistedFormState =
        usePreservedState('categoryFormState', context, defaultValue);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Редактирование профиля'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.done_rounded,
                size: 30,
              ),
              onPressed: () async {
                final formVal = persistedFormState.value;
                await supabase
                    .from('profiles')
                    .update({'nick': formVal['nick']}).eq(
                        'uid', supabase.auth.currentUser!.id);
                await rofileController.getUpdatedNick();
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
                TextInput(name: 'nick', title: 'Никнейм'),
              ],
            ),
          ),
        ));
  }
}
