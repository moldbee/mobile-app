import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';

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
                      Image.network(
                        'https://flagsapi.com/MD/flat/64.png',
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
                      Image.network(
                        'https://flagsapi.com/IT/flat/64.png',
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
      body: const Text('Hello'),
    );
  }
}
