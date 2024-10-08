import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/discounts.dart';
import 'package:smart_city/features/services/screens/items.dart';
import 'package:smart_city/l10n/main.dart';

class ServicesScreen extends HookWidget {
  const ServicesScreen({super.key});
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
        ],
      ),
      body: Obx(() => ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (context, index) {
              final category = servicesController.categories[index];
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.pushNamed(const ServicesCompaniesScreen().route,
                      queryParameters: {
                        'categoryId': category['id'].toString()
                      });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        IconData(int.parse(category['icon']!),
                            fontFamily: 'MaterialIcons'),
                        color: Colors.orange.shade300,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(category['title_$locale'],
                          style: Theme.of(context).textTheme.titleMedium!)
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
