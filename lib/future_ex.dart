import 'dart:async';

extension FutureEx on Future {
  static Future<T> atLeast<T>(Future<T> action, Duration duration) =>
      Future.wait([action, Future.delayed(duration)])
          .then((value) => value.first);
  Future minimum(Duration duration) => FutureEx.atLeast(this, duration);
}

extension FutureOrEx<T> on Future<T> {
  Future<T> atLeast(Duration duration) => FutureEx.atLeast(this, duration);
}
