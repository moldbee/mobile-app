import 'package:flutter/material.dart';

class CompanyPromotionsScreen extends StatelessWidget {
  const CompanyPromotionsScreen({super.key, this.id});
  final route = '/services/company/promotions';

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Акции / Metro'),
      ),
      body: ListView(
        children: const [Text('Promotion 1')],
      ),
    );
  }
}
