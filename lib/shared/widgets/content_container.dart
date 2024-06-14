import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: child,
    );
  }
}
