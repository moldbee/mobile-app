import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/category_upsert.dart';
import 'package:smart_city/features/services/screens/items.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/widgets/tile.dart';

class ServicesScreen extends HookWidget {
  const ServicesScreen({Key? key}) : super(key: key);
  final String route = '/services';

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Услуги"),
        actions: [
          if (Permissions().getForServiceCategories()) ...[
            IconButton(
                onPressed: () async {
                  context.push(const ServiceCategoryUpsert().route);
                },
                icon: const Icon(Icons.add_home_work_rounded)),
          ]
        ],
      ),
      body: Obx(() => GridView.count(
            crossAxisCount: 3,
            children: servicesController.categories.map((element) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.pushNamed(const ServicesCompaniesScreen().route,
                      queryParameters: {
                        'categoryId': element['id'].toString()
                      });
                },
                child: Tile(
                  title: element['title_ru'],
                  icon: IconData(element['icon'], fontFamily: 'MaterialIcons'),
                  iconColor: Colors.orange.shade300,
                ),
              );
            }).toList(),
          )),
    );
  }
}
