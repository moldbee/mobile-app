import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  const EventTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('⛪ Встреча верующих',
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w500))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.grey.shade400,
                ),
              ),
              const Text(
                '19 июля, 2023 12:30 (Суббота)',
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.place_rounded,
                  color: Colors.grey.shade400,
                ),
              ),
              const Text(
                'Церковь "Вифанья"',
              )
            ],
          ),
        )
      ],
    );
  }
}
