import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/events/widgets/details_tile.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/features/services/screens/company_services.dart';
import 'package:smart_city/features/services/screens/contacts.dart';
import 'package:smart_city/features/services/screens/faq.dart';
import 'package:smart_city/features/services/screens/info.dart';
import 'package:smart_city/features/services/screens/offices.dart';
import 'package:smart_city/features/services/screens/promotions.dart';
import 'package:smart_city/l10n/main.dart';

class ServiceDetailsScreen extends HookWidget {
  const ServiceDetailsScreen({Key? key, this.serviceId}) : super(key: key);
  final String route = '/service/details';

  final String? serviceId;
  @override
  Widget build(BuildContext context) {
    final blinkingAnimationController =
        useAnimationController(duration: const Duration(milliseconds: 500));
    blinkingAnimationController.repeat(reverse: true);
    final locale = getAppLoc(context)!.localeName;
    final servicesController = Get.find<ServicesController>();
    final selectedService = servicesController.services.firstWhere(
        (element) => element['id'].toString() == serviceId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedService['title_$locale'],
          style: TextStyle(color: Colors.grey.shade900),
        ),
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (selectedService['logo'] != null) ...[
                  const SizedBox(
                    height: 16,
                  ),
                  Image.network(
                    selectedService['logo'],
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    height: 100,
                    width: double.infinity,
                  ),
                ],
              ],
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 50),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                ServiceDetailsTile(
                    onTap: () {
                      context.pushNamed(const CompanyServicesScreen().route,
                          queryParameters: {'companyId': serviceId});
                    },
                    icon: Icons.grid_view_rounded,
                    title: 'Услуги'),
                ServiceDetailsTile(
                  onTap: () {
                    context.pushNamed(const CompanyPromotionsScreen().route,
                        queryParameters: {'companyId': serviceId});
                  },
                  icon: Icons.percent_rounded,
                  title: 'Акции',
                  iconColor: Colors.red,
                ),
                ServiceDetailsTile(
                    onTap: () {
                      context.pushNamed(const CompanyFaqScreen().route,
                          queryParameters: {'companyId': serviceId});
                    },
                    icon: Icons.question_answer_rounded,
                    title: 'FAQ'),
                ServiceDetailsTile(
                    onTap: () {
                      context.pushNamed(const CompanyContactsScreen().route,
                          queryParameters: {'companyId': serviceId});
                    },
                    icon: Icons.contacts_sharp,
                    title: 'Контакты'),
                ServiceDetailsTile(
                    onTap: () {
                      context.pushNamed(const CompanyOfficesScreen().route,
                          queryParameters: {'companyId': serviceId});
                    },
                    icon: Icons.apartment_rounded,
                    title: 'Адреса'),
                ServiceDetailsTile(
                    onTap: () {
                      context.pushNamed(const CompanyInfoScreen().route,
                          queryParameters: {'companyId': serviceId});
                    },
                    icon: Icons.info_rounded,
                    title: 'Информация'),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// SizedBox(
//               width: double.infinity,
//               child: Card(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Market',
//                             style: TextStyle(
//                                 fontSize: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium!
//                                     .fontSize,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey.shade800),
//                           ),
//                           FadeTransition(
//                             opacity: blinkingAnimationController,
//                             child: Container(
//                               margin: const EdgeInsets.only(right: 10),
//                               height: 10,
//                               width: 10,
//                               decoration: const BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(50))),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 4,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Click to see on map',
//                             style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .fontSize),
//                           ),
//                           const Text('18:30')
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),