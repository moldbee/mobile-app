import 'package:flutter/material.dart';

class ProfileNotifications extends StatelessWidget {
  const ProfileNotifications({Key? key}) : super(key: key);
  final String route = '/profile/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои комментарии'),
      ),
      body: const Center(
        child: Text('Комментарии'),
      ),
    );
  }
}
