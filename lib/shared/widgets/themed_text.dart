import 'package:flutter/material.dart';

enum Col { title, subtitle, body, caption }

class TextVariant {
  final double fontSize;
  final FontWeight fontWeight;

  const TextVariant(this.fontSize, this.fontWeight);
}

class TextType {
  static TextVariant title = const TextVariant(18, FontWeight.w500);
  static TextVariant subtitle = const TextVariant(16, FontWeight.w400);
  static TextVariant info = const TextVariant(14, FontWeight.w400);
  static TextVariant infoSmall = const TextVariant(12, FontWeight.w400);
  static TextVariant label = const TextVariant(10, FontWeight.w400);
}

class ThemedText extends StatelessWidget {
  const ThemedText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    required this.variant,
  });

  final String text;
  final TextVariant variant;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: variant.fontSize,
        fontWeight: variant.fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
