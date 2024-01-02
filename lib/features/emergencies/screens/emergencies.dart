import 'package:flutter/material.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/shared/widgets/call_button.dart';

class EmergenciesScreen extends StatelessWidget {
  const EmergenciesScreen({Key? key}) : super(key: key);
  final route = '/emergencies';

  @override
  Widget build(BuildContext context) {
    final List<Map> items = [
      {
        'title': getAppLoc(context)!.police,
        'icon': Icons.local_police_rounded,
        'number': '112',
        'iconColor': Colors.blue.shade500,
      },
      {
        'title': getAppLoc(context)!.ambulance,
        'icon': Icons.local_hospital_rounded,
        'number': '112',
        'iconColor': Colors.red.shade500,
      },
      {
        'title': getAppLoc(context)!.fire,
        'icon': Icons.local_fire_department_rounded,
        'number': '112',
        'iconColor': Colors.orange.shade400,
      },
      {
        'title': 'RED-Nord',
        'icon': Icons.bolt_rounded,
        'number': '0231 5-32-06',
        'iconColor': Colors.yellow.shade500,
      },
      {
        'title': getAppLoc(context)!.gasService,
        'icon': Icons.propane_tank_rounded,
        'number': '904',
        'iconColor': Colors.orange.shade400,
      },
      {
        'title': 'CET-NORD',
        'icon': Icons.water_drop_rounded,
        'number': '0231 9-10-00',
        'iconColor': Colors.blue.shade500,
      },
      {
        'title': getAppLoc(context)!.liftSupportService,
        'icon': Icons.elevator_rounded,
        'number': '0231 8-00-49',
        'iconColor': Colors.orange.shade400,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(getAppLoc(context)!.emergency),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              title: Text(
                items[index]['title'],
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: Theme.of(context).textTheme.titleSmall!.fontSize),
              ),
              leading: Icon(
                items[index]['icon'],
                color: items[index]['iconColor'] as Color,
                size: 40,
              ),
              trailing: CallButton(
                  uri: Uri(scheme: 'tel', path: items[index]['number']!)),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 10,
                thickness: .1,
                color: Colors.grey.shade500,
              ),
          itemCount: items.length),
    );
  }
}
