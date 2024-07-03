import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/details.dart';
import 'package:smart_city/features/services/widgets/company_tile.dart';
import 'package:smart_city/l10n/main.dart';

class ServicesCompaniesScreen extends StatelessWidget {
  const ServicesCompaniesScreen({super.key, this.categoryId});
  final String route = '/services/companies';

  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final locale = getAppLoc(context)!.localeName;
    final category = servicesController.categories.firstWhere(
        (element) => element['id'].toString() == categoryId.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category['title_$locale'],
        ),
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
                title: company['title_$locale'],
              ),
            );
          }).toList()),
    );
  }
}
