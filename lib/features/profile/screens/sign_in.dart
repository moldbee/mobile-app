import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_city/features/profile/controller.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/profile/screens/sign_up.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
import 'package:smart_city/l10n/main.dart';
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

    Future<void> fetchAndSetProfile() async {
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

    void signIn() async {
      try {
        _formKey.currentState?.save();
        if (_formKey.currentState!.validate()) {
          final data = _formKey.currentState!.value;
          await supabase.auth.signInWithPassword(
              email: data['login'], password: data['password']);
          await fetchAndSetProfile();
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error: $e');

        if (e is AuthException) {
          // Check the type of exception and handle it.
          if (e.statusCode == '400') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 1),
                content: Text(getAppLoc(context)!.wrongEmailOrPassword),
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
          title: Text(getAppLoc(context)!.signIn),
          actions: [
            IconButton(
                onPressed: () {
                  context.push(const SettingsScreen().route);
                },
                icon: const Icon(
                  Icons.settings,
                )),
          ],
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
                  TextInput(name: 'login', title: getAppLoc(context)!.email),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      name: 'password',
                      title: getAppLoc(context)!.password,
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
                              child: Text(
                                getAppLoc(context)!.signIn,
                                style: const TextStyle(color: Colors.white),
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
                              child: Text(getAppLoc(context)!.signUp)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      getAppLoc(context)!.or,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            /// Web Client ID that you registered with Google Cloud.
                            const webClientId =
                                '310797220104-1ek32g9adpvl8ai2giaka1k3jisikfn6.apps.googleusercontent.com';

                            /// iOS Client ID that you registered with Google Cloud.
                            // const iosClientId =
                            //     'my-ios.apps.googleusercontent.com';

                            // Google sign in on Android will work without providing the Android
                            // Client ID registered on Google Cloud.
                            final GoogleSignIn googleSignIn = GoogleSignIn(
                              serverClientId: webClientId,
                            );
                            final googleUser = await googleSignIn.signIn();
                            final googleAuth = await googleUser!.authentication;
                            final accessToken = googleAuth.accessToken;
                            final idToken = googleAuth.idToken;

                            if (accessToken == null) {
                              throw 'No Access Token found.';
                            }
                            if (idToken == null) {
                              throw 'No ID Token found.';
                            }

                            await supabase.auth.signInWithIdToken(
                              provider: Provider.google,
                              idToken: idToken,
                              accessToken: accessToken,
                            );

                            await fetchAndSetProfile();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.grey.shade800)),
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          label: Text(
                            getAppLoc(context)!.googleAuth,
                            style: const TextStyle(color: Colors.white),
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
