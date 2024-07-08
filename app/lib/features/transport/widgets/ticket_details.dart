import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/transport/screens/book_ticket.dart';
import 'package:smart_city/l10n/main.dart';

class TicketDetailsScreen extends HookWidget {
  const TicketDetailsScreen({super.key});
  final route = '/transport/tickets/details';

  @override
  Widget build(BuildContext context) {
    final loc = getAppLoc(context);

    precacheImage(
        const NetworkImage(
            'https://infogari.md/images/cars/original_size/140.jpg'),
        context);

    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        OutlinedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ListTile(
                          leading: Icon(Icons.list_rounded),
                          title: Text('In autobuz este'),
                          subtitle: Text('Wi-Fi, Mancare, Viceu, Macaroane'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.pin_outlined),
                          title: Text('Numarul autobuzului'),
                          subtitle: Text('BLD 517'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.network(
                            'https://infogari.md/images/cars/original_size/140.jpg')
                      ],
                    );
                  });
            },
            child: const Text('Info about bus')),
        const SizedBox(
          width: 10,
        ),
        FilledButton(
            onPressed: () {
              context.pushNamed(const BookTicketScreen().route);
            },
            child: const Text('Book for 500 MDL')),
      ],
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        children: const [
          ListTile(
            title: Text('Descrierea'),
            leading: Icon(Icons.description),
            subtitle: Text(
                'The bus runs without a stopover, making mandatory stops at the borders of the transited countries and towns along the route.'),
          ),
          ListTile(
            leading: Icon(Icons.place_rounded),
            title: Text('9 august, 21:30'),
            subtitle: Text('Str. Mihai Eminescu 28/1'),
          ),
          ListTile(
            leading: Icon(Icons.pin_drop_rounded),
            title: Text('10 august, 21:30'),
            subtitle: Text('Str. Mihai Eminescu 28/1'),
          ),
          ListTile(
            leading: Icon(Icons.timer_rounded),
            title: Text('Drumul va lua'),
            subtitle: Text('10 ore 30 minute'),
          ),
          ListTile(
            leading: Icon(Icons.emoji_transportation_rounded),
            title: Text('Compania'),
            subtitle: Text('SRL GalTrans'),
          ),
          ListTile(
            leading: Icon(
              Icons.percent_rounded,
              color: Colors.red,
            ),
            title: Text('Reducere'),
            subtitle: Text('Pentru copii pana la 14 ani si 1 an'),
          ),
        ],
      ),
    );
  }
}
