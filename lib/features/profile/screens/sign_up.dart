import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/screens/policy.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSignUpScreen extends HookWidget {
  ProfileSignUpScreen({Key? key}) : super(key: key);
  final String route = '/profile/sign-up';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final SizedBox spacing = const SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final isAgree = useState(false);
    final profileController = Get.find<ProfileController>();
    final isLoading = useState(false);

    void signUp() async {
      try {
        isLoading.value = true;
        _formKey.currentState?.save();
        if (_formKey.currentState!.validate()) {
          final data = _formKey.currentState!.value;
          await supabase.auth
              .signUp(email: data['login'], password: data['password']);
          await supabase.from('profiles').update({
            'nick': data['nick'],
          }).eq('uid', supabase.auth.currentUser!.id);
          final profile = await supabase
              .from('profiles')
              .select()
              .eq('uid', supabase.auth.currentUser!.id)
              .single();
          profileController.setProfileData(
              avatar: profile['avatar'],
              nick: profile['nick'],
              email: profile['email']);
          if (!context.mounted) return;
          context.go(ProfileScreen().route);
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error: $e');
        if (e is AuthException) {
          // Check the type of exception and handle it.
          if (e.statusCode == '400') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Пользователь с такой почтой уже существует'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Регистрация"),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: const {
              'login': 'artenngordas@gmail.com',
              'password': '12345678',
              'password2': '12345678',
              'nick': 'Artem Gordash',
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextInput(
                    name: 'login',
                    title: 'Почта',
                    type: TextInputType.emailAddress,
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Это поле обязательно для заполнения'),
                      FormBuilderValidators.email(
                          errorText: 'Введите корректный адрес почты')
                    ],
                  ),
                  spacing,
                  TextInput(name: 'nick', title: 'Никнейм', validators: [
                    FormBuilderValidators.required(
                        errorText: 'Это поле обязательно для заполнения'),
                    FormBuilderValidators.minLength(3,
                        errorText: 'Никнейм должен быть не менее 3 символов'),
                    FormBuilderValidators.maxLength(20,
                        errorText: 'Никнейм должен быть не более 20 символов')
                  ]),
                  spacing,
                  TextInput(
                    name: 'password',
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Это поле обязательно для заполнения'),
                      FormBuilderValidators.minLength(8,
                          errorText: 'Пароль должен быть не менее 8 символов')
                    ],
                    title: 'Пароль',
                    isPassword: true,
                  ),
                  spacing,
                  TextInput(
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Это поле обязательно для заполнения',
                      ),
                      FormBuilderValidators.equal(
                          _formKey.currentState?.instantValue['password'] ?? '',
                          errorText: 'Пароли не совпадают')
                    ],
                    name: 'password2',
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
                              onPressed: isAgree.value ? signUp : null,
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: FilledButton.icon(
                  //           onPressed: () {},
                  //           style: ButtonStyle(
                  //               backgroundColor: MaterialStatePropertyAll(
                  //                   Colors.grey.shade800)),
                  //           icon: const Icon(
                  //             FontAwesomeIcons.instagram,
                  //             color: Colors.white,
                  //           ),
                  //           label: const Text(
                  //             'Войти через Facebook',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
