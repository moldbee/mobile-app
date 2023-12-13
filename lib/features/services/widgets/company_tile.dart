import 'package:flutter/material.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({Key? key, required this.logoUrl, required this.title})
      : super(key: key);

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
          child: Text(
            title,
            style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize),
          ),
        ),
      ],
    );
  }
}
