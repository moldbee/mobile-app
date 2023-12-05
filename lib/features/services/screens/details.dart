import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/alert_upsert.dart';
import 'package:smart_city/features/services/screens/discount_upsert.dart';
import 'package:smart_city/features/services/screens/info_upsert.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/config/permissions.dart';
import 'package:smart_city/shared/utils/formatter.dart';
import 'package:smart_city/shared/widgets/content_block.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends HookWidget {
  const ServiceDetailsScreen({Key? key, this.serviceId}) : super(key: key);
  final String route = '/service/details';

  final String? serviceId;
  @override
  Widget build(BuildContext context) {
    final locale = getAppLoc(context)!.localeName;
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
          selectedService['title_$locale'] as String,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse(selectedService['place']));
              },
              icon: const Icon(Icons.place_rounded)),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedService['logo'] != null) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.network(
                      selectedService['logo'],
                      fit: BoxFit.scaleDown,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                ContentBlock(
                    title: 'Контакты',
                    enableTopDivider: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri(
                                scheme: 'tel', path: selectedService['phone']));
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
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                ContentBlock(
                  title: 'Описание',
                  child: Text(
                    selectedService['description_$locale'],
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            if (Permissions().getForCompany(selectedService['owner'])) ...[
              ContentBlock(
                  title: 'Управление',
                  child: Column(children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 40,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            OutlinedButton.icon(
                                icon: const Icon(Icons.percent_rounded),
                                onPressed: () {
                                  context.pushNamed(
                                      const ServiceDiscountUpsert().route,
                                      queryParameters: {
                                        'serviceId': serviceId
                                      });
                                },
                                label: Text(getAppLoc(context)!.addDiscount)),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton.icon(
                                icon: const Icon(Icons.info_outline_rounded),
                                onPressed: () {
                                  context.pushNamed(
                                      const ServiceInfoUpsert().route,
                                      queryParameters: {
                                        'serviceId': serviceId
                                      });
                                },
                                label: Text(getAppLoc(context)!.addInfo)),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton.icon(
                                icon: const Icon(Icons.warning_amber_rounded),
                                onPressed: () {
                                  context.pushNamed(
                                      const ServiceAlertUpsert().route,
                                      queryParameters: {
                                        'serviceId': serviceId
                                      });
                                },
                                label: Text(getAppLoc(context)!.addAlert)),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
            ],
            // SizedBox(
            //   height: 300,
            //   width: double.infinity,
            //   child: WebViewWidget(
            //       controller: WebViewController()
            //         ..setJavaScriptMode(JavaScriptMode.unrestricted)
            //         ..loadHtmlString(
            //             '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d10726.284406369314!2d27.9457687!3d47.770373!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x40cb60d99ec69f6f%3A0x1488c68f28449553!2sVerix%20Centru!5e0!3m2!1sro!2s!4v1701034539385!5m2!1sro!2s" width="100%" style="border:0;" allowfullscreen="true" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>')),
            // ),
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
                                    item['description_$locale'] as String,
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
                                    item['description_$locale'] as String,
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
                                    item['description_$locale'] as String,
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
