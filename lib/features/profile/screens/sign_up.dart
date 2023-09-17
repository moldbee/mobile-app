import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/shared/screens/policy.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class ProfileSignUpScreen extends HookWidget {
  ProfileSignUpScreen({Key? key}) : super(key: key);
  final String route = '/profile/sign-up';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final SizedBox spacing = const SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final isAgree = useState(false);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Регистрация"),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextInput(name: 'login', title: 'Почта'),
                  spacing,
                  const TextInput(name: 'login', title: 'Никнейм'),
                  spacing,
                  const TextInput(
                    name: 'password',
                    title: 'Пароль',
                    isPassword: true,
                  ),
                  spacing,
                  const TextInput(
                    name: 'password',
                    title: 'Введите пароль еще раз',
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isAgree.value,
                          onChanged: (value) {
                            isAgree.value = value!;
                          }),
                      GestureDetector(
                        onTap: () {
                          isAgree.value = !isAgree.value;
                        },
                        child: Text('Я согласен с условиями использования',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade600)),
                      ),
                      GestureDetector(
                          onTap: () {
                            context.push(const PolicyScreen().route);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.link,
                              color: Colors.orange.shade200,
                            ),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: FilledButton(
                              onPressed: isAgree.value ? () {} : null,
                              child: const Text(
                                'Регистрация',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                  // make a divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'или',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.grey.shade800)),
                          icon: const Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Войти через Facebook',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.grey.shade800)),
                            icon: const Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Войти через Facebook',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
