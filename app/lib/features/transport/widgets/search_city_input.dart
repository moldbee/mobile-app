// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/helpers/replace_romanian_chars.dart';

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
    final loc = getAppLoc(context);

    Future<List> fetchData() async {
      final response = await supabase
          .from('transport_cities')
          .select('title_ru, title_ro, country_code')
          .or('title_ru.ilike.%${replaceRomanianChars(query)}%, title_ro.ilike.%${replaceRomanianChars(query)}%');

      return response;
    }

    return FutureBuilder<List>(
        future: fetchData(),
        builder: (context, snapshot) {
          ListView children;
          if (snapshot.hasData) {
            children = ListView.separated(
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  final title = item['title_${loc!.localeName}'];

                  return InkWell(
                    onTap: () {
                      close(context, title);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            height: 15,
                            width: 25,
                            child: Flag.fromString(item['country_code']),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.length);
          } else if (snapshot.hasError) {
            children = ListView(
              children: const [],
            );
          } else {
            children = ListView(
              children: const [],
            );
          }
          return children;
        });
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
      keyboardType: TextInputType.none,
      controller: searchController,
      showCursor: false,
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
