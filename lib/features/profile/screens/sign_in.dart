import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';

class ProfileSignInScreen extends StatelessWidget {
  ProfileSignInScreen({Key? key}) : super(key: key);
  final String route = '/profile/sign-in';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Вход"),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextInput(name: 'login', title: 'Почта'),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: TextInput(
                      name: 'password',
                      title: 'Пароль',
                      isPassword: true,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: FilledButton(
                              onPressed: () {
                                context.push(const ProfileScreen().route);
                              },
                              child: const Text(
                                'Войти',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                context.push(ProfileSignUpScreen().route);
                              },
                              child: const Text('Регистрация')),
                        )
                      ],
                    ),
                  ),
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
