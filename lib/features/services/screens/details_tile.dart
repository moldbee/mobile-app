import 'package:flutter/material.dart';
import 'package:smart_city/shared/config/pallete.dart';

class ServiceDetailsTile extends StatelessWidget {
  const ServiceDetailsTile(
      {super.key,
      required this.icon,
      this.iconColor,
      required this.onTap,
      required this.title});

  final IconData icon;
  final String title;
  final Color? iconColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap as void Function()?,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: mutedBgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: mutedColor, width: .2)),
            child: Icon(
              icon,
              color: iconColor ?? Colors.orange.shade400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
