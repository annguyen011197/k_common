import 'package:flutter/material.dart';

class AutoFitGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final int? rows;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  /// A grid that automatically fits its children to fill the available space
  /// without scrolling.
  ///
  /// [crossAxisCount] - Number of columns
  /// [rows] - Optional number of rows. If null, calculated based on children count
  /// [spacing] - Spacing between items (both horizontal and vertical)
  /// [padding] - Padding around the entire grid
  /// [children] - The grid items
  const AutoFitGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.rows,
    this.spacing = 8.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate rows if not specified
        final int itemCount = children.length;
        final int actualRows =
            rows ?? ((itemCount + crossAxisCount - 1) ~/ crossAxisCount);

        // Calculate the size available for the grid
        final EdgeInsetsGeometry actualPadding =
            padding ?? EdgeInsets.all(spacing);
        final double paddingHorizontal = actualPadding.horizontal;
        final double paddingVertical = actualPadding.vertical;

        // Available width and height after padding
        final double availableWidth = constraints.maxWidth - paddingHorizontal;
        final double availableHeight = constraints.maxHeight - paddingVertical;

        // Calculate grid spaces consumed by spacing
        final double horizontalSpacingTotal = spacing * (crossAxisCount - 1);
        final double verticalSpacingTotal = spacing * (actualRows - 1);

        // Calculate the space available for actual items
        final double itemWidth =
            (availableWidth - horizontalSpacingTotal) / crossAxisCount;
        final double itemHeight =
            (availableHeight - verticalSpacingTotal) / actualRows;

        // Final aspect ratio of each item
        final double aspectRatio = itemWidth / itemHeight;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          padding: actualPadding,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: children,
        );
      },
    );
  }
}
