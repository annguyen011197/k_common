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

extension Cast<T> on dynamic {
  T? as<T>() {
    if (this is T) {
      return this as T;
    }
    return null;
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedDate() {
    return '${'${day}'.padLeft(2, '0')}/${'${month}'.padLeft(2, '0')}/$year';
  }

  String toFormatedTime() {
    return '${'${hour}'.padLeft(2, '0')}:${'${minute}'.padLeft(2, '0')}:${'${second}'.padLeft(2, '0')}';
  }
}

extension DurationExtension on Duration {
  String toHHMMSS() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(inHours);
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
