import 'package:flutter/material.dart';

class CompanyPromotionsScreen extends StatelessWidget {
  const CompanyPromotionsScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/promotions';

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Акции / Metro'),
      ),
      body: ListView(
        children: [
          Container(
            child: Text('Promotion 1'),
          )
        ],
      ),
    );
  }
}
