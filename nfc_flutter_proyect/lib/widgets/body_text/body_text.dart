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
        Theme.of(context).textTheme.bodyLarge ?? const TextStyle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: textStyle?.copyWith(
                  color: color,
                  height:
                      25 / (textStyle?.fontSize ?? defaultStyle.fontSize!)) ??
              defaultStyle.copyWith(color: color),
        ),
      ),
    );
  }
}
