import 'package:flutter/material.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/info';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Информация'),
        ),
        body: ListView(
          children: [
            Container(
              child: Text('Info 1'),
            )
          ],
        ));
  }
}
