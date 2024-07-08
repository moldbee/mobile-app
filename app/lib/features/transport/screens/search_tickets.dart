import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/transport/screens/how_to_add_route.dart';
import 'package:smart_city/features/transport/screens/search_tickets_list.dart';
import 'package:smart_city/features/transport/widgets/search_city_input.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/date_time_picker.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchTicketsScreen extends HookWidget {
  const SearchTicketsScreen({super.key});
  final route = '/transport';

  @override
  Widget build(BuildContext context) {
    final fromCityController = useSearchController();
    final toCityController = useSearchController();
    final dateTimeController = useTextEditingController();
    final passangersController = useState<double>(0.0);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    loc.passengers,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey.shade400),
                  ),
                  Expanded(
                    child: Slider(
                      label: '${passangersController.value.truncate()}',
                      value: toDouble(passangersController.value) as double,
                      onChanged: (value) {
                        passangersController.value = value;
                      },
                      max: 10,
                      divisions: 10,
                      min: 0,
                    ),
                  ),
                ],
              ),
              spacing,
              spacing,
              FilledButton.icon(
                onPressed: () {
                  context.pushNamed(const TicketsListScreen().route);
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
