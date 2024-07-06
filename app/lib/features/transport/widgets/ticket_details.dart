import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/text_item.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key});
  final route = '/transport/tickets/details';

  @override
  Widget build(BuildContext context) {
    final loc = getAppLoc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.ticket_details),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CountryFlag.fromCountryCode(
                        'MD',
                        height: 20,
                        width: 30,
                      ),
                      Text(
                        'Chisinau',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                    child: Icon(
                      Icons.remove_rounded,
                      grade: -90,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Roma',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      CountryFlag.fromCountryCode(
                        'IT',
                        height: 20,
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextItem(
                  title: 'Pornirea pe:',
                  child: Text(
                    '9 august, 19:30',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              TextItem(
                  title: 'Pornirea din:',
                  child: Text(
                    'Chisinau, Strada Calea Moşilor 2/1',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              TextItem(
                  title: 'Pornirea pe:',
                  child: Text(
                    '9 august, 19:30',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              TextItem(
                  title: 'Pornirea pe:',
                  child: Text(
                    '9 august, 19:30',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                'The route from Chisinau to Rome is an exciting journey from the capital of Moldova to the heart of Italy. This path covers diverse landscapes, historical landmarks, and cultural treasures, offering travelers a unique experience as they traverse Eastern and Southern Europe.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        useSafeArea: true,
                        isDismissible: true,
                        builder: (context) {
                          return SizedBox(
                            width: context.mediaQuerySize.width,
                            height: context.mediaQuerySize.height,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextItem(
                                            title: 'Номер автобуса:',
                                            child: Text('BLD 250')),
                                        TextItem(
                                            title: 'Удобства:',
                                            child: Text(
                                                'WC, WI-FI, Air Conditioning, Meal'))
                                      ],
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                  'https://infogari.md/images/cars/original_size/140.jpg',
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: const Text('Bus Info')),
            ],
          ),
        ),
      ),
    );
  }
}
