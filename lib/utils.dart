extension TakeIf<T> on T? {
  /// Return the current value if the given block is satisifed, will return
  /// `null` if not.
  T? takeIf(bool Function(T it) block) {
    return switch (this) {
      var _this? => block(_this) ? _this : null,
      _ => null,
    };
  }
}

extension Let<T> on T {
  /// Calls the specified `block` with the current value as its argument.
  R let<R>(R Function(T it) block) {
    return block(this);
  }
}

extension Intersperse<E> on List<E> {
  List<E> intersperse(E separator) {
    if (isEmpty) return [];
    return List.generate(
      length * 2 - 1,
      (i) => i.isEven ? this[i ~/ 2] : separator,
    );
  }
}

extension IntersperseIterable<E> on Iterable<E> {
  Iterable<E> intersperse(E separator) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return;

    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }
}
