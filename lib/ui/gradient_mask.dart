import 'package:flutter/widgets.dart';

class GradientMaskImage extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final BlendMode blendMode;

  const GradientMaskImage({
    super.key,
    required this.child,
    required this.gradient,
    this.blendMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: blendMode,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}

class ColorMaskImage extends StatelessWidget {
  final Widget child;
  final Color color;
  final BlendMode blendMode;

  const ColorMaskImage({
    super.key,
    required this.child,
    required this.color,
    this.blendMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(color, blendMode), child: child);
  }
}
