import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/screens/company.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({Key? key, required this.logoUrl, required this.title})
      : super(key: key);

  final String logoUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(const ServiceCompanyScreen().route,
            queryParameters: {'logoUrl': logoUrl, 'title': title});
      },
      child: Column(
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
          ),
        ],
      ),
    );
  }
}
