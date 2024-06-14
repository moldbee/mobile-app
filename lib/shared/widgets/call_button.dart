import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.uri});

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.green.shade600)),
        onPressed: () {
          launchUrl(uri);
        },
        icon: const Icon(
          Icons.phone_rounded,
          color: Colors.white,
        ));
  }
}
