import 'package:flutter/material.dart';

class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: child,
    );
  }
}
