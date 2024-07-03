import 'package:flutter/material.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({super.key, required this.logoUrl, required this.title});

  final dynamic logoUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (logoUrl is int) ...[
          Icon(
            IconData(logoUrl, fontFamily: 'MaterialIcons'),
            size: 40,
            color: Colors.grey.shade400,
          ),
        ] else ...[
          Image.network(
            logoUrl!,
            height: 50,
          ),
        ],
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium!),
        ),
      ],
    );
  }
}
