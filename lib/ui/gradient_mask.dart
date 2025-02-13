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
