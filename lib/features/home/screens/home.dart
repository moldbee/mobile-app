import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/home/screens/emergencies.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/settings/screens/about.dart';
import 'package:smart_city/features/settings/screens/settings.dart';
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
        'go': () => context.push(const ServicesScreen().route)
      },
      {
        'title': 'Услуги',
        'icon': Icons.apartment_rounded,
        'iconColor': Colors.orange.shade300,
        'route': const ServicesScreen().route,
        'go': () => context.push(const ServicesScreen().route)
      },
      {
        'title': 'Новости',
        'icon': Icons.newspaper_rounded,
        'iconColor': Colors.orange.shade300,
        'go': () => context.push(const NewsScreen().route)
      },
      {
        'title': 'Секции',
        'icon': Icons.sports_soccer,
        'iconColor': Colors.orange.shade300,
        'go': () => context.push(const ServicesScreen().route)
      },
      {
        'title': 'Клубы',
        'icon': Icons.group_rounded,
        'iconColor': Colors.orange.shade300,
        'go': () => context.push(const ServicesScreen().route)
      },
      {
        'title': 'Афиша',
        'icon': Icons.event_rounded,
        'iconColor': Colors.orange.shade300,
        'go': () => context.push(const NewsScreen().route)
      },
      {
        'title': 'Экстренные службы',
        'icon': Icons.emergency_rounded,
        'iconColor': Colors.red.shade500,
        'go': () => context.push(const EmergenciesScreen().route)
      },
      {
        'title': 'Настройки',
        'icon': Icons.settings_rounded,
        'iconColor': Colors.orange.shade300,
        'go': () => context.push(const SettingsScreen().route)
      },
      {
        'title': 'О приложении',
        'icon': Icons.info_rounded,
        'iconColor': Colors.orange.shade300,
        'go': () => context.push(const AboutScreen().route)
      },
      {
        'title': 'Контакты',
        'icon': Icons.support_rounded,
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
