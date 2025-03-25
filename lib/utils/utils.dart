import 'dart:async';

class Utils {
  static FutureOr<T?> guardAsync<T>(FutureOr<T> Function() future,
      {Function(dynamic, StackTrace)? onError}) async {
    try {
      final value = await future();
      return value;
    } catch (err, stack) {
      onError?.call(err, stack);
      return null;
    }
  }

  static T? guard<T>(T Function() run,
      {Function(dynamic, StackTrace)? onError}) {
    try {
      final value = run();
      return value;
    } catch (err, stack) {
      onError?.call(err, stack);
      return null;
    }
  }
}
