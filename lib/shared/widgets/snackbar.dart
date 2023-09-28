import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {Key? key,
      required this.content,
      this.backgroundColor = Colors.red,
      this.duration = const Duration(seconds: 1)})
      : super(key: key);

  final String content;
  final Duration duration;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
      duration: duration,
    );
  }
}
