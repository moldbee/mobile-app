import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/transport/widgets/ticket_details.dart';

class RouteTicketCard extends StatelessWidget {
  const RouteTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        context.pushNamed(const TicketDetailsScreen().route);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.network(
                        'https://flagsapi.com/MD/flat/64.png',
                        width: 20,
                      ),
                      Text(
                        'Chisinaul',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '26 august 19:30',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.wifi_rounded,
                        color: Colors.grey.shade400,
                      ),
                      Icon(
                        Icons.wc_rounded,
                        color: Colors.grey.shade400,
                      ),
                      Icon(
                        Icons.air_rounded,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    '32h 30m',
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.straight_rounded,
                      grade: -90,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Rome',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Image.network(
                        'https://flagsapi.com/IT/flat/64.png',
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '6 august 19:30',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.orange.shade400,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text('500 MDL',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                )),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
