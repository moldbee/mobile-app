import 'package:flutter/material.dart';

class DoneIconButton extends StatelessWidget {
  const DoneIconButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.done,
          size: 26,
          color: Colors.orange.shade300,
        ));
  }
}
