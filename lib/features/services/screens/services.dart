import 'package:flutter/material.dart';
import 'package:smart_city/features/services/widgets/tile.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);
  final String route = '/services';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Услуги"),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: [
            ServiceTile(
              title: 'Недвижимость',
              icon: Icons.apartment_rounded,
              color: Colors.blue.shade500,
            ),
            ServiceTile(
                title: 'Еда',
                icon: Icons.food_bank_rounded,
                color: Colors.yellow.shade500),
            ServiceTile(
              title: 'Спорт',
              icon: Icons.sports_basketball_rounded,
              color: Colors.green.shade500,
            ),
            ServiceTile(
              title: 'Недвижимость',
              icon: Icons.apartment_rounded,
              color: Colors.blue.shade500,
            ),
            ServiceTile(
                title: 'Еда',
                icon: Icons.food_bank_rounded,
                color: Colors.yellow.shade500),
            ServiceTile(
              title: 'Спорт',
              icon: Icons.sports_basketball_rounded,
              color: Colors.green.shade500,
            ),
            ServiceTile(
              title: 'Недвижимость',
              icon: Icons.apartment_rounded,
              color: Colors.blue.shade500,
            ),
            ServiceTile(
              title: 'Спорт',
              icon: Icons.sports_basketball_rounded,
              color: Colors.green.shade500,
            ),
            ServiceTile(
                title: 'Еда',
                icon: Icons.food_bank_rounded,
                color: Colors.yellow.shade500),
            ServiceTile(
              title: 'Недвижимость',
              icon: Icons.apartment_rounded,
              color: Colors.blue.shade500,
            ),
            ServiceTile(
                title: 'Еда',
                icon: Icons.food_bank_rounded,
                color: Colors.yellow.shade500),
            ServiceTile(
              title: 'Недвижимость',
              icon: Icons.apartment_rounded,
              color: Colors.blue.shade500,
            ),
            ServiceTile(
              title: 'Спорт',
              icon: Icons.sports_basketball_rounded,
              color: Colors.green.shade500,
            ),
            ServiceTile(
                title: 'Еда',
                icon: Icons.food_bank_rounded,
                color: Colors.yellow.shade500),
            ServiceTile(
              title: 'Спорт',
              icon: Icons.sports_basketball_rounded,
              color: Colors.green.shade500,
            ),
          ],
        ));
  }
}
