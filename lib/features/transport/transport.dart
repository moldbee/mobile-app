import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_city/features/transport/widgets/search_city_input.dart';
import 'package:smart_city/shared/widgets/scaffold_body.dart';

class TransportScreen extends HookWidget {
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
    final todayDate = DateTime.now();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Transport'),
        ),
        body: ScaffoldBody(
          child: Column(
            children: [
              CitySearchInput(
                  hint: 'From', searchController: fromCityController),
              spacing,
              CitySearchInput(
                hint: 'To',
                searchController: toCityController,
              ),
              spacing,
              TextField(
                controller: dateTimeController,
                keyboardType: TextInputType.none,
                decoration: const InputDecoration(hintText: 'Date'),
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: todayDate,
                      lastDate: DateTime(
                          todayDate.year + 1, todayDate.month, todayDate.day));

                  if (!context.mounted) return;

                  final time = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 06, minute: 00));
                },
              ),
            ],
          ),
        ));
  }
}
