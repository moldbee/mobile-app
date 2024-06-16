import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactItem {
  final String title;
  final IconData icon;
  final String url;

  ContactItem({required this.title, required this.icon, required this.url});
}

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});
  final String route = '/settings/about';

  @override
  Widget build(BuildContext context) {
    final localiz = getAppLoc(context)!;
    final items = [
      ContactItem(
          title: 'Facebook',
          icon: Icons.facebook_rounded,
          url: 'https://www.facebook.com/profile.php?id=61560856989877'),
      ContactItem(
          title: 'Mail',
          icon: Icons.mail_rounded,
          url: 'mailto:artenngordas@gmail.com'),
      ContactItem(
          title: 'Instagram',
          icon: FontAwesomeIcons.instagram,
          url: 'https://www.instagram.com/moldbee.md/'),
      ContactItem(
          title: 'LinkedIn',
          icon: FontAwesomeIcons.linkedin,
          url: 'https://www.linkedin.com/company/moldbee/'),
    ];
    return Scaffold(
        appBar: AppBar(title: Text(localiz.contacts)),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final item = items.elementAt(index);
              return GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(item.url));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  )),
                      Icon(
                        item.icon,
                        size: 32,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: .1,
                ),
            itemCount: items.length));
  }
}
