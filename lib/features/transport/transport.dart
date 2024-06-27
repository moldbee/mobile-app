import 'package:flutter/material.dart';
import 'package:smart_city/features/transport/widgets/search_city_input.dart';
import 'package:smart_city/shared/widgets/date_time_picker.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});
  final route = '/transport';

  @override
  Widget build(BuildContext context) {
    final fromCityController = SearchController();
    final toCityController = SearchController();
    final dateTimeController = TextEditingController();

    const spacing = SizedBox(
      height: 10,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Transport'),
        ),
        body: ScaffoldBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CitySearchInput(
                  hint: 'From', searchController: fromCityController),
              spacing,
              CitySearchInput(
                hint: 'To',
                searchController: toCityController,
              ),
              spacing,
              DateTimePicker(controller: dateTimeController),
              spacing,
              FilledButton(
                onPressed: () {},
                child: const Text('Search'),
              )
            ],
          ),
        ));
  }
}
