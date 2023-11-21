import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  final String? title;
  final String? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconData(int.parse(icon!), fontFamily: 'MaterialIcons'),
            color: iconColor as Color,
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
