import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.title,
    required this.icon,
    this.iconSize,
  });

  final String title;
  final IconData icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          size: iconSize ?? 40,
          color: Colors.grey.shade400,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        )
      ],
    );
  }
}
