import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_city/features/services/screens/companies.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile(
      {Key? key, required this.title, required this.icon, required this.color})
      : super(key: key);

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.push(const ServicesCompaniesScreen().route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.grey.shade400,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey.shade800),
            ),
          )
        ],
      ),
    );
  }
}
