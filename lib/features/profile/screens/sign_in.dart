import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/widgets/form/text_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSignInScreen extends HookWidget {
  ProfileSignInScreen({Key? key}) : super(key: key);
  final String route = '/profile/sign-in';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final profileController = Get.find<ProfileController>();

    void signIn() async {
      try {
        _formKey.currentState?.save();
        if (_formKey.currentState!.validate()) {
          final data = _formKey.currentState!.value;
          await supabase.auth.signInWithPassword(
              email: data['login'], password: data['password']);
          final profile = await supabase
              .from('profiles')
              .select('*, role(name)')
              .eq('uid', supabase.auth.currentUser!.id)
              .single();
          profileController.setProfileData(
              role: profile['role']['name'],
              avatar: profile['avatar'],
              nick: profile['nick'],
              email: profile['email'],
              uid: profile['uid'],
              id: profile['id'].toString());

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
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
                content: Text('Неверный логин или пароль'),
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
          title: const Text("Вход"),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: const {
              'login': 'artenngordas@gmail.com',
              'password': '12345678',
            },
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
                              onPressed: isLoading.value ? null : signIn,
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
