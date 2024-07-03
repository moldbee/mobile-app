import 'package:flutter/material.dart';

class CompanyContactsScreen extends StatelessWidget {
  const CompanyContactsScreen({super.key, this.id});
  final route = '/services/company/contacts';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контакты / Metro'),
      ),
      body: ListView(
        children: const [Text('Contacts 1')],
      ),
    );
  }
}
