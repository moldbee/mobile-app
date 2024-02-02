import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  final String route = '/settings/about';

  @override
  Widget build(BuildContext context) {
    final localiz = getAppLoc(context)!;
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(localiz.about_app_description,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              children: [
                FilledButton(
                  child: const Text(
                    'Instagram',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    launchUrl(
                        Uri.parse('https://www.instagram.com/gordash.io/'));
                  },
                ),
                const SizedBox(width: 10),
                FilledButton(
                  child: const Text(
                    'Telegram',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    launchUrl(
                        Uri.parse('https://t.me/shsghsjeiwowksjxjeieiehwb'));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
