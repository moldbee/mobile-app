import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/details.dart';
import 'package:smart_city/features/services/screens/upsert.dart';
import 'package:smart_city/features/services/widgets/company_tile.dart';
import 'package:smart_city/shared/widgets/delete_confirm.dart';

class ServicesCompaniesScreen extends StatelessWidget {
  const ServicesCompaniesScreen({Key? key, this.id}) : super(key: key);
  final String route = '/services/companies';

  final String? id;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final category = servicesController.categories
        .firstWhere((element) => element['id'].toString() == id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(category['title_ru']),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => DeleteConfirmAlert(
                          onDelete: () async {
                            await servicesController.deleteCategory(id!);
                          },
                        ));
              },
              icon: const Icon(Icons.delete_rounded)),
          IconButton(
            onPressed: () {
              context.push(ServiceUpsert(
                categoryId: id,
              ).route);
            },
            icon: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: GridView.count(
          childAspectRatio: 4 / 3,
          crossAxisCount: 2,
          children:
              servicesController.getServicesByCategory(id!).map((company) {
            return GestureDetector(
              onTap: () {
                context.pushNamed(const ServiceDetailsScreen().route,
                    queryParameters: {
                      'logoUrl': company['logo'],
                      'title': company['title_ru']
                    });
              },
              child: CompanyTile(
                logoUrl: company['logo'],
                title: company['title_ru'],
              ),
            );
          }).toList()),
    );
  }
}
