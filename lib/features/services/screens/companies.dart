import 'package:flutter/material.dart';
import 'package:smart_city/features/services/widgets/company_tile.dart';

class ServicesCompaniesScreen extends StatelessWidget {
  const ServicesCompaniesScreen({Key? key}) : super(key: key);
  final String route = '/services/companies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Компании / Еда')),
      body: GridView.count(
        childAspectRatio: 4 / 3,
        crossAxisCount: 2,
        children: const [
          CompanyTile(
            title: 'Metro',
            logoUrl: 'assets/metro.png',
          ),
          CompanyTile(
            title: 'Linella',
            logoUrl: 'assets/linella.png',
          ),
        ],
      ),
    );
  }
}
