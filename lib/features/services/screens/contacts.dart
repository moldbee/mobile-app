import 'package:flutter/material.dart';

class CompanyContactsScreen extends StatelessWidget {
  const CompanyContactsScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/contacts';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контакты / Metro'),
      ),
      body: ListView(
        children: [
          Container(
            child: Text('Contacts 1'),
          )
        ],
      ),
    );
  }
}
