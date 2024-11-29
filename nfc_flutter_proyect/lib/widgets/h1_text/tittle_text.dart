import 'package:flutter/material.dart';

class TittleText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;

  const TittleText({
    super.key,
    required this.text,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle =
        Theme.of(context).textTheme.displayLarge ?? const TextStyle();

    return Text(
      text,
      style: textStyle?.copyWith(color: color) ??
          defaultStyle.copyWith(color: color),
    );
  }
}