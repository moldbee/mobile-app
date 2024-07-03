// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names

import 'dart:convert';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class City {
  final String name;
  final String countryCode;
  final String asciiName;
  final String labelEn;

  City({
    required this.name,
    required this.countryCode,
    required this.asciiName,
    required this.labelEn,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      countryCode: json['country_code'] as String,
      asciiName: json['ascii_name'] as String,
      labelEn: json['label_en'] as String,
    );
  }
}

class CityResponse {
  final int totalCount;
  final List<City> results;

  CityResponse({
    required this.totalCount,
    required this.results,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'] as List;
    List<City> resultsList = resultsJson.map((i) => City.fromJson(i)).toList();

    return CityResponse(
      totalCount: json['total_count'] as int,
      results: resultsList,
    );
  }
}

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
    Future<List<City>> fetchData() async {
      final response = await http.get(Uri.parse(
          'https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/geonames-all-cities-with-a-population-1000/records?select=name, country_code, ascii_name, label_en, alternate_names, population&where=search(name, "$query") OR search(alternate_names, "$query")&order_by=population DESC&limit=30&lang=eu&refine=timezone:"Europe"'));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        CityResponse cityResponse = CityResponse.fromJson(body);
        return cityResponse.results;
      } else {
        throw Exception('Failed to load data');
      }
    }

    return FutureBuilder<List<City>>(
        future: fetchData(),
        builder: (context, snapshot) {
          ListView children;
          if (snapshot.hasData) {
            children = ListView.separated(
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  final flag = CountryFlag.fromCountryCode(item.countryCode);
                  return InkWell(
                    onTap: () {
                      close(context, '${item.countryCode}, ${item.name}');
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
                            child: flag,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            item.name,
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
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
