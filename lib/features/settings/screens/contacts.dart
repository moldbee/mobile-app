import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';

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
          url: 'https://facebook.com'),
      ContactItem(
          title: 'Mail', icon: Icons.mail_rounded, url: 'https://facebook.com'),
      ContactItem(
          title: 'Facebook',
          icon: Icons.facebook_rounded,
          url: 'https://facebook.com'),
    ];
    return Scaffold(
        appBar: AppBar(title: Text(localiz.contacts)),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final item = items.elementAt(index);
              return Padding(
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
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: .1,
                ),
            itemCount: items.length));
  }
}
