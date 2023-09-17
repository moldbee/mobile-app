import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  final String route = '/settings/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Commodo eu sunt fugiat quis voluptate voluptate. Ea adipisicing Lorem pariatur laboris enim ut nisi dolor aliqua ut consequat. Culpa irure dolore sit veniam qui. Ea labore magna aute ipsum ad nostrud elit est do velit. Mollit nostrud aliquip ullamco amet officia tempor non incididunt eiusmod mollit cupidatat mollit mollit nostrud. Amet et velit dolore cillum cillum sint ullamco minim exercitation commodo sunt et amet. Commodo est enim dolore ipsum est nulla commodo dolor exercitation id enim.',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
