extension TakeIf<T> on T? {
  /// Return the current value if the given block is satisifed, will return
  /// `null` if not.
  T? takeIf(bool Function(T it) block) {
    return switch (this) {
      var _this? => block(_this) ? _this : null,
      _ => null
    };
  }
}

extension Let<T> on T {
  /// Calls the specified `block` with the current value as its argument.
  R let<R>(R Function(T it) block) {
    return block(this);
  }
}
