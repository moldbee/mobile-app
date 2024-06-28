import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, this.id});
  final route = '/auth';
  final String? id;

  @override
  Widget build(context) {
    final loc = getAppLoc(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(loc!.signIn),
        ),
        body: ScaffoldBody(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.emoji_nature_rounded,
                size: 50,
                color: Colors.orange.shade400,
              ),
              const SizedBox(
                height: 30,
              ),
              OutlinedButton.icon(
                  icon: const Icon(FontAwesomeIcons.google),
                  onPressed: () {},
                  label: Text(loc.googleAuth)),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                  iconAlignment: IconAlignment.start,
                  icon: const Icon(FontAwesomeIcons.apple),
                  onPressed: () {},
                  label: Text(loc.appleAuth))
            ],
          ),
        ));
  }
}
