import 'package:flutter/material.dart';

class FlexContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final int flex;
  final FlexFit fit;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  /// A hybrid widget that combines Container styling with Flex/Expanded behavior
  ///
  /// [child] - The widget below this widget in the tree
  /// [color] - The color to paint behind the child
  /// [decoration] - The decoration to paint behind the child
  /// [padding] - Empty space to inscribe inside the decoration
  /// [margin] - Empty space to surround the decoration
  /// [alignment] - Alignment of the child within this container
  /// [flex] - Flex factor to use in parent Flex widgets (like Row/Column)
  /// [fit] - How this container should fit in available space
  /// [constraints] - Additional constraints to apply to the child
  /// [width] - The width of this container, if specified
  /// [height] - The height of this container, if specified
  /// [borderRadius] - Border radius shorthand (only used if decoration is null)
  const FlexContainer({
    super.key,
    this.child,
    this.color,
    this.decoration,
    this.padding,
    this.margin,
    this.alignment,
    this.flex = 1,
    this.fit = FlexFit.tight,
    this.constraints,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Create the container with all styling properties
    Widget container = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      decoration: decoration ??
          (borderRadius != null
              ? BoxDecoration(
                  color: color,
                  borderRadius: borderRadius,
                )
              : (color != null ? BoxDecoration(color: color) : null)),
      child: child,
    );

    // Wrap with Flexible to handle flex behavior
    return Flexible(
      flex: flex,
      fit: fit,
      child: container,
    );
  }
}
