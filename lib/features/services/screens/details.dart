import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/controller.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/helpers/show_delete_confirm.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key, this.serviceId}) : super(key: key);
  final String route = '/service/details';

  final String? serviceId;

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();

    final selectedService = servicesController.services.firstWhere(
        (element) => element['id'].toString() == serviceId.toString());
    // final serviceCategory = servicesController.categories.firstWhere(
    //     (element) =>
    //         element['id'].toString() == selectedService['category'].toString());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        backgroundColor: Colors.grey.shade200,
        title: Text(
          selectedService['title_ru'] as String,
          style: TextStyle(
              color: Colors.grey.shade800, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await showDeleteConfirm(() async {
                  await supabase
                      .from('services')
                      .delete()
                      .eq('id', selectedService['id']);
                  await servicesController.fetchServices();
                  if (!context.mounted) return;
                  context.pop();
                }, context, disableDoublePop: true);
              },
              icon: const Icon(Icons.delete_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        height: 100,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runAlignment: WrapAlignment.center,
                        children: [
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green.shade600)),
                              onPressed: () {
                                launchUrl(Uri(
                                    scheme: 'tel',
                                    path: selectedService['phone']));
                              },
                              icon: const Icon(
                                Icons.phone_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () {
                                launchUrl(
                                    Uri.parse(selectedService['website']));
                              },
                              icon: const Icon(
                                Icons.public,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () {
                                launchUrl(
                                    Uri.parse(selectedService['message']));
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () {
                                launchUrl(Uri.parse(selectedService['place']));
                              },
                              icon: const Icon(
                                Icons.place_rounded,
                                color: Colors.white,
                              )),
                        ],
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
            // SingleChildScrollView(
            //   child: SizedBox(
            //     height: 40,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         const SizedBox(
            //           width: 15,
            //         ),
            //         OutlinedButton.icon(
            //             icon: const Icon(Icons.percent_rounded),
            //             onPressed: () {},
            //             label: const Text('Добавить скидку')),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         OutlinedButton.icon(
            //             icon: const Icon(Icons.attach_money_rounded),
            //             onPressed: () {},
            //             label: const Text('Добавить цену')),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         OutlinedButton.icon(
            //             icon: const Icon(Icons.info_outline_rounded),
            //             onPressed: () {},
            //             label: const Text('Добавить информацию')),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         OutlinedButton.icon(
            //             icon: const Icon(Icons.warning_amber_rounded),
            //             onPressed: () {},
            //             label: const Text('Добавить предупреждение')),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
