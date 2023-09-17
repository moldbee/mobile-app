import 'package:flutter/material.dart';
import 'package:smart_city/features/services/widgets/company_tile.dart';

class ServicesOtherScreen extends StatelessWidget {
  const ServicesOtherScreen({Key? key}) : super(key: key);
  final String route = '/services/other';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Компании / Еда')),
      body: GridView.count(
        childAspectRatio: 4 / 3,
        crossAxisCount: 2,
        children: const [
          CompanyTile(
            title: 'Чистюля',
            logoUrl: 'assets/metro.png',
          ),
          CompanyTile(
            title: 'Санитар',
            logoUrl: 'assets/linella.png',
          ),
        ],
      ),
    );
  }
}
