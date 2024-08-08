import 'package:flutter/material.dart';

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t) => isEmpty
      ? []
      : (enumerate.map((e) => [e.value, t]).expand((i) => i).toList()
    ..removeLast());

  List<Widget> around(Widget t) => addToStart(t).addToEnd(t);

  List<Widget> addToStart(Widget t) =>
      enumerate.map((e) => e.value).toList()..insert(0, t);

  List<Widget> addToEnd(Widget t) =>
      enumerate.map((e) => e.value).toList()..add(t);

  List<Padding> paddingTopEach(double val) =>
      map((w) => Padding(padding: EdgeInsets.only(top: val), child: w))
          .toList();

  List<Widget> spacing(Spacing spacing) => divide(spacing.sizedBox());
}

extension WidgetEx on Widget {
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget addPadding(EdgeInsets value) {
    return Padding(
      padding: value,
      child: this,
    );
  }

  Widget scrollable() {
    return SingleChildScrollView(
      child: this,
    );
  }

  Widget touchable(Function() onTap) => InkWell(
    onTap: onTap,
    child: this,
  );

  Widget flexible() => Flexible(child: this);

  Widget flex(int value) => Expanded(flex: value, child: this);

  Widget background({
    required Color color,
    BorderRadiusGeometry? borderRadius,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
  }) =>
      Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: this,
      );
}

sealed class Spacing {
  double value;

  Spacing(this.value);

  static Spacing h(double value) => SpacingH(value);
  static Spacing v(double value) => SpacingV(value);

  Widget sizedBox() => switch (this) {
    SpacingV(:var value) => SizedBox(height: value),
    SpacingH(:var value) => SizedBox(width: value),
  };
}

class SpacingV extends Spacing {
  SpacingV(super.value);
}

class SpacingH extends Spacing {
  SpacingH(super.value);
}
