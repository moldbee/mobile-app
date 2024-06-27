import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_city/features/transport/widgets/search_city_input.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/date_time_picker.dart';
import 'package:smart_city/shared/widgets/number_input.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class TransportScreen extends HookWidget {
  const TransportScreen({super.key});
  final route = '/transport';

  @override
  Widget build(BuildContext context) {
    final fromCityController = SearchController();
    final toCityController = SearchController();
    final dateTimeController = TextEditingController();
    final places = useState(0.0);

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
            children: [
              CitySearchInput(
                  hint: loc.from, searchController: fromCityController),
              spacing,
              CitySearchInput(
                hint: loc.to,
                searchController: toCityController,
              ),
              spacing,
              DateTimePicker(
                controller: dateTimeController,
                hint: loc.when,
              ),
              spacing,
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('На сколько людей')),
                    Flexible(child: NumberInput())
                  ],
                ),
              ),
              spacing,
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('На сколько людей')),
                    Flexible(child: NumberInput())
                  ],
                ),
              ),
              spacing,
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('На сколько людей')),
                    Flexible(child: NumberInput())
                  ],
                ),
              ),
              spacing,
              spacing,
              FilledButton(
                onPressed: () {},
                child: Text(loc.search),
              ),
              spacing,
              const Divider(),
              spacing,
              const Text(
                'I want to add my ticket',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                ),
              )
            ],
          ),
        ));
  }
}
