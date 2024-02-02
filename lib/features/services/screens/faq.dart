import 'package:flutter/material.dart';

class CompanyFaqScreen extends StatelessWidget {
  const CompanyFaqScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/faq';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ / Metro'),
      ),
      body: ListView(
        children: [
          Container(
            child: Text('FAQ 1'),
          )
        ],
      ),
    );
  }
}
