import 'package:flutter/material.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/shared/widgets/tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final route = '/';

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Скидки',
        'icon': Icons.percent_rounded,
        'iconColor': Colors.red.shade500,
      },
      {
        'title': 'Услуги',
        'icon': Icons.apartment_rounded,
        'iconColor': Colors.orange.shade300,
        'route': const ServicesScreen().route
      },
      {
        'title': 'Новости',
        'icon': Icons.newspaper_rounded,
        'iconColor': Colors.orange.shade300,
      },
      {
        'title': 'Секции',
        'icon': Icons.sports_soccer,
        'iconColor': Colors.orange.shade300,
      },
      {
        'title': 'Клубы',
        'icon': Icons.group_rounded,
        'iconColor': Colors.orange.shade300,
      },
      {
        'title': 'Афиша',
        'icon': Icons.event_rounded,
        'iconColor': Colors.orange.shade300,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: items
            .map((item) => Tile(
                title: item['title'] as String,
                icon: item['icon'] as IconData,
                iconColor: item['iconColor'] as Color))
            .toList(),
      ),
    );
  }
}
