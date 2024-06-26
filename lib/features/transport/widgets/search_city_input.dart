import 'package:flutter/material.dart';

class CitySearchInput extends StatelessWidget {
  const CitySearchInput(
      {super.key, required this.hint, required this.searchController});

  final String hint;
  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        searchController: searchController,
        viewOnSubmitted: (text) {
          searchController.closeView(text);
        },
        builder: (BuildContext context, SearchController controller) {
          return TextField(
            decoration: InputDecoration(hintText: hint),
            controller: controller,
            onTap: () {
              controller.openView();
            },
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                controller.closeView(item);
              },
            );
          });
        });
  }
}
