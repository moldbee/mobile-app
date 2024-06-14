import 'package:flutter/material.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key, this.id});
  final route = '/services/company/info';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Информация'),
        ),
        body: ListView(
          children: const [Text('Info 1')],
        ));
  }
}
