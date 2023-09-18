import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/screens/companies.dart';
import 'package:smart_city/features/services/screens/upsert.dart';
import 'package:smart_city/features/services/widgets/details.dart';
import 'package:smart_city/features/services/widgets/tile.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';

class ServicesScreen extends HookWidget {
  const ServicesScreen({Key? key}) : super(key: key);
  final String route = '/services';

  @override
  Widget build(BuildContext context) {
    final selectedTab = usePreservedState('services-tabbar', context, 0);

    return DefaultTabController(
      length: 2,
      initialIndex: selectedTab.value,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Услуги"),
            bottom: TabBar(
              onTap: (index) {
                selectedTab.value = index;
              },
              tabs: const <Widget>[
                Tab(
                    icon: Text(
                  'Основные',
                )),
                Tab(
                  icon: Text(
                    'Секции',
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.push(ServiceUpsert().route);
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              )
            ],
          ),
          body: TabBarView(
            children: [
              GridView.count(
                crossAxisCount: 3,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(const ServicesCompaniesScreen().route);
                    },
                    child: const ServiceTile(
                      title: 'Недвижимость',
                      icon: Icons.apartment_rounded,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const ServicesCompaniesScreen().route);
                    },
                    child: const ServiceTile(
                      title: 'Еда',
                      icon: Icons.food_bank_rounded,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const ServicesCompaniesScreen().route);
                    },
                    child: const ServiceTile(
                      title: 'Спорт',
                      icon: Icons.sports_basketball_rounded,
                    ),
                  ),
                ],
              ),
              GridView.count(
                crossAxisCount: 3,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(const ServiceDetailsScreen().route,
                          queryParameters: {
                            'logoUrl': 'assets/okinawa.png',
                            'title': 'OKINAWA'
                          });
                    },
                    child: const ServiceTile(
                      title: 'OKINAWA',
                      icon: Icons.sports_martial_arts_rounded,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(const ServiceDetailsScreen().route,
                          queryParameters: {
                            'logoUrl': 'assets/okinawa.png',
                            'title': 'OKINAWA'
                          });
                    },
                    child: const ServiceTile(
                      title: 'DK Raut',
                      icon: Icons.sports_mma_rounded,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(const ServiceDetailsScreen().route,
                          queryParameters: {
                            'logoUrl': 'assets/okinawa.png',
                            'title': 'OKINAWA'
                          });
                    },
                    child: const ServiceTile(
                      title: 'OLIMPIA',
                      icon: Icons.sports_soccer_rounded,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
