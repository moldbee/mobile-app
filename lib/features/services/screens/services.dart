import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/category_upsert.dart';
import 'package:smart_city/features/services/screens/discounts.dart';
import 'package:smart_city/features/services/screens/items.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/permissions.dart';

class ServicesScreen extends HookWidget {
  const ServicesScreen({Key? key}) : super(key: key);
  final String route = '/services';

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final locale = getAppLoc(context)!.localeName;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getAppLoc(context)!.services),
        actions: [
          IconButton(
              onPressed: () {
                context.push(const DiscountsScreen().route);
              },
              icon: Icon(
                Icons.percent_rounded,
                color: Colors.red.shade500,
              )),
          if (Permissions().getForServiceCategories()) ...[
            IconButton(
                onPressed: () async {
                  context.push(const ServiceCategoryUpsert().route);
                },
                icon: const Icon(Icons.add_home_work_rounded)),
          ]
        ],
      ),
      body: Obx(() => ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (context, index) {
              final element = servicesController.categories[index];
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.pushNamed(const ServicesCompaniesScreen().route,
                      queryParameters: {
                        'categoryId': element['id'].toString()
                      });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        IconData(int.parse(element['icon']!),
                            fontFamily: 'MaterialIcons'),
                        color: Colors.orange.shade300,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        element['title_$locale'],
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .fontSize),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 10,
                thickness: .1,
                color: Colors.grey.shade500,
              );
            },
            itemCount: servicesController.categories.length,
          )),
    );
  }
}
