import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final cities = [
  'Moldova, Chisinau',
  'Moldova, Balti',
  'Italy, Rome',
  'UK, London'
];

class CitySearchDelegant extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: cities.where((city) {
        return city.toLowerCase().contains(query.toLowerCase());
      }).map((city) {
        return ListTile(
          title: Text(city),
          onTap: () {
            close(context, city);
          },
        );
      }).toList(),
    );
  }
}

class CitySearchInput extends StatelessWidget {
  const CitySearchInput(
      {super.key, required this.hint, required this.searchController});

  final String hint;
  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    final delegant = CitySearchDelegant();

    return TextField(
      controller: searchController,
      decoration: InputDecoration(
          hintText: hint, prefixIcon: const Icon(Icons.place_rounded)),
      onTap: () async {
        final value = await showSearch(
            context: context, delegate: delegant, useRootNavigator: true);
        if (value != null) {
          searchController.value = TextEditingValue(text: value);
        }
      },
    );
  }
}
