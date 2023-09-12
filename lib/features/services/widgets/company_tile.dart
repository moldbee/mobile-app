import 'package:flutter/material.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({Key? key, required this.logoUrl, required this.title})
      : super(key: key);

  final String logoUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          logoUrl,
          width: 150,
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
          ),
        )
      ],
    );
  }
}
