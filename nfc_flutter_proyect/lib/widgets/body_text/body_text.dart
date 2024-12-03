import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;

  const BodyText({
    super.key,
    required this.text,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle =
        Theme.of(context).textTheme.bodyLarge?.copyWith(height: 16) ??
            const TextStyle(height: 1.0);

    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: textStyle?.copyWith(
                color: color,
                height: 25 / (textStyle?.fontSize ?? defaultStyle.fontSize!)) ??
            defaultStyle.copyWith(color: color),
      ),
    );
  }
}
