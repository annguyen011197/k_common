import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
    super.key,
    this.maxLines,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        maxLines: maxLines,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
