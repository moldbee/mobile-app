import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_city/l10n/main.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, this.id});
  final route = '/auth';
  final String? id;

  @override
  Widget build(context) {
    final locales = getAppLoc(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(locales!.signIn),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.key_rounded,
                size: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              OutlinedButton.icon(
                  icon: const Icon(FontAwesomeIcons.google),
                  onPressed: () {},
                  label: const Text('Sign in using Google')),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                  iconAlignment: IconAlignment.start,
                  icon: const Icon(FontAwesomeIcons.apple),
                  onPressed: () {},
                  label: const Text('Sign in using Google'))
            ],
          ),
        ));
  }
}
