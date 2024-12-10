import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  const LargeText({
    super.key,
    required this.text,
    this.color,
    this.textStyle,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle =
        Theme.of(context).textTheme.titleLarge ?? const TextStyle();

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 25),
        child: Text(
          textAlign: textAlign,
          text,
          style: textStyle?.copyWith(color: color) ??
              defaultStyle.copyWith(color: color),
        ),
      ),
    );
  }
}
