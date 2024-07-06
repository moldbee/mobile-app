import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/transport/screens/how_to_add_route.dart';
import 'package:smart_city/features/transport/screens/search_tickets.dart';
import 'package:smart_city/features/transport/widgets/search_city_input.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/date_time_picker.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class TransportScreen extends HookWidget {
  const TransportScreen({super.key});
  final route = '/transport';

  @override
  Widget build(BuildContext context) {
    final fromCityController = useSearchController();
    final toCityController = useSearchController();
    final dateTimeController = useTextEditingController();
    final sortByController = useState<String?>(null);

    const spacing = SizedBox(
      height: 10,
    );

    final loc = getAppLoc(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(loc!.transport),
        ),
        body: ScaffoldBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CitySearchInput(
                  hint: loc.from, searchController: fromCityController),
              spacing,
              CitySearchInput(
                hint: loc.to,
                searchController: toCityController,
              ),
              spacing,
              DatePicker(
                controller: dateTimeController,
                hint: loc.when,
              ),
              spacing,
              SegmentedButton(
                emptySelectionAllowed: true,
                style: SegmentedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.grey.shade400,
                  selectedForegroundColor: Colors.white,
                  selectedBackgroundColor: Colors.orange.shade400,
                ),
                showSelectedIcon: false,
                segments: <ButtonSegment>[
                  ButtonSegment(
                    value: 'cheapest',
                    label: Text(loc.cheaper),
                  ),
                  ButtonSegment(
                    value: 'fastest',
                    label: Text(loc.faster),
                  ),
                  ButtonSegment(
                    value: 'comfortest',
                    label: Text(loc.comfortable),
                  ),
                ],
                selected: {sortByController.value},
                onSelectionChanged: (Set newSelection) {
                  if (newSelection.isNotEmpty) {
                    sortByController.value = newSelection.toList()[0];
                    return;
                  }

                  sortByController.value = null;
                },
              ),
              spacing,
              spacing,
              FilledButton.icon(
                onPressed: () {
                  context.pushNamed(const RoutesScreen().route);
                },
                icon: const Icon(Icons.search_rounded),
                label: Text(loc.search),
              ),
              spacing,
              const Divider(),
              spacing,
              GestureDetector(
                onTap: () {
                  context.pushNamed(const HowToAddRouteScreen().route);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc.wantToAddTicket,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
