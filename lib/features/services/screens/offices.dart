import 'package:flutter/material.dart';

class CompanyOfficesScreen extends StatelessWidget {
  const CompanyOfficesScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/offices';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Офисы / Metro'),
      ),
      body: ListView(
        children: const [Text('Offices 1')],
      ),
    );
  }
}
