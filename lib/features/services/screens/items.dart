import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/details.dart';
import 'package:smart_city/features/services/screens/upsert.dart';
import 'package:smart_city/features/services/widgets/company_tile.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';

class ServicesCompaniesScreen extends StatelessWidget {
  const ServicesCompaniesScreen({Key? key, this.categoryId}) : super(key: key);
  final String route = '/services/companies';

  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final category = servicesController.categories.firstWhere(
        (element) => element['id'].toString() == categoryId.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(category['title_ru']),
        actions: [
          if (Permissions().getForServiceCategories()) ...[
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) => DeleteConfirmAlert(
                            onDelete: () async {
                              await servicesController
                                  .deleteCategory(categoryId!);
                            },
                          ));
                },
                icon: const Icon(Icons.delete_rounded))
          ],
          if (Permissions().getForServices()) ...[
            IconButton(
              onPressed: () {
                context.pushNamed(ServiceUpsert().route,
                    queryParameters: {'categoryId': categoryId});
              },
              icon: const Icon(
                Icons.add_rounded,
                size: 30,
              ),
            )
          ]
        ],
      ),
      body: GridView.count(
          childAspectRatio: 5 / 3,
          crossAxisCount: 2,
          children: servicesController
              .getServicesByCategory(categoryId!)
              .map((company) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                context.pushNamed(const ServiceDetailsScreen().route,
                    queryParameters: {
                      'serviceId': company['id'].toString(),
                    });
              },
              child: CompanyTile(
                logoUrl: company['logo'] ?? category['icon'],
                title: company['title_ru'],
              ),
            );
          }).toList()),
    );
  }
}
