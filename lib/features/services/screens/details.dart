import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/alert_upsert.dart';
import 'package:smart_city/features/services/screens/discount_upsert.dart';
import 'package:smart_city/features/services/screens/info_upsert.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/utils/formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends HookWidget {
  const ServiceDetailsScreen({Key? key, this.serviceId}) : super(key: key);
  final String route = '/service/details';

  final String? serviceId;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final discounts =
        servicesController.getDiscountsForService(serviceId as String);
    final alerts = servicesController.getAlertsForService(serviceId as String);
    final infos = servicesController.getInfosForService(serviceId as String);
    final selectedService = servicesController.services.firstWhere(
        (element) => element['id'].toString() == serviceId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedService['title_ru'] as String,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse(selectedService['message']));
              },
              icon: const Icon(Icons.send_rounded)),
          // if (Permissions().getForCompany(selectedService['owner'])) ...[
          //   IconButton(
          //       onPressed: () {
          //         context.pushNamed(ServiceUpsert().route,
          //             queryParameters: {'serviceId': serviceId, 'categoryId': selectedService['category'].toString()});
          //       },
          //       icon: const Icon(Icons.edit_rounded)),
          //   IconButton(
          //       onPressed: () async {
          //         await showDeleteConfirm(() async {
          //           await supabase
          //               .from('services')
          //               .delete()
          //               .eq('id', selectedService['id']);
          //           await servicesController.fetchServices();
          //           if (!context.mounted) return;
          //           context.pop();
          //         }, context, disableDoublePop: true);
          //       },
          //       icon: const Icon(Icons.delete_rounded)),
          // ]
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedService['logo'] != null) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        selectedService['logo'],
                        fit: BoxFit.scaleDown,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(selectedService['website']));
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        spacing: 6,
                        children: [
                          Icon(
                            Icons.public_rounded,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          Text(
                            selectedService['website'],
                            style:
                                const TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(Uri(scheme: 'tel', path: selectedService['phone']));
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          spacing: 6,
                          children: [
                            Icon(
                              Icons.phone_rounded,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                            Text(
                              selectedService['phone'],
                              style:
                                  const TextStyle(color: Colors.blue, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        selectedService['description_ru'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )),
            if (Permissions().getForCompany(selectedService['owner'])) ...[
              SingleChildScrollView(
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton.icon(
                          icon: const Icon(Icons.percent_rounded),
                          onPressed: () {
                            context.pushNamed(
                                const ServiceDiscountUpsert().route,
                                queryParameters: {'serviceId': serviceId});
                          },
                          label: const Text('Добавить скидку')),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton.icon(
                          icon: const Icon(Icons.info_outline_rounded),
                          onPressed: () {
                            context.pushNamed(const ServiceInfoUpsert().route,
                                queryParameters: {'serviceId': serviceId});
                          },
                          label: const Text('Добавить информацию')),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton.icon(
                          icon: const Icon(Icons.warning_amber_rounded),
                          onPressed: () {
                            context.pushNamed(const ServiceAlertUpsert().route,
                                queryParameters: {'serviceId': serviceId});
                          },
                          label: const Text('Добавить предупреждение')),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (discounts.isNotEmpty)
              ...discounts.map((item) => Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(const ServiceDiscountUpsert().route,
                            queryParameters: {
                              'serviceId': serviceId,
                              'discountId': item['id'].toString()
                            });
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.percent_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['description_ru'] as String,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  if (item['start_date'] != 'null' &&
                                      item['end_date'] != 'null') ...[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${formatter(context).format(DateTime.parse(item['start_date']))} - ${formatter(context).format(DateTime.parse(item['end_date']))}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ]
                                ],
                              )),
                            ],
                          )),
                    ),
                  )),
            if (alerts.isNotEmpty)
              ...alerts.map((item) => Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(const ServiceAlertUpsert().route,
                            queryParameters: {
                              'serviceId': serviceId,
                              'alertId': item['id'].toString()
                            });
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.warning_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['description_ru'] as String,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  if (item['start_date'] != 'null' &&
                                      item['end_date'] != 'null') ...[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${formatter(context).format(DateTime.parse(item['start_date']))} - ${formatter(context).format(DateTime.parse(item['end_date']))}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ]
                                ],
                              )),
                            ],
                          )),
                    ),
                  )),
            if (infos.isNotEmpty)
              ...infos.map((item) => Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(const ServiceInfoUpsert().route,
                            queryParameters: {
                              'serviceId': serviceId,
                              'infoId': item['id'].toString()
                            });
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['description_ru'] as String,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  if (item['start_date'] != 'null' &&
                                      item['end_date'] != 'null') ...[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${formatter(context).format(DateTime.parse(item['start_date']))} - ${formatter(context).format(DateTime.parse(item['end_date']))}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ]
                                ],
                              )),
                            ],
                          )),
                    ),
                  )),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
