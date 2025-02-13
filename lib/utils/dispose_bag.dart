import 'dart:async';

class DisposeBag {
  final List<StreamSubscription> _subscriptions = [];
  bool _isDisposed = false;

  /// Adds a StreamSubscription to the dispose bag
  void add(StreamSubscription subscription) {
    if (_isDisposed) {
      subscription.cancel();
      throw StateError('DisposeBag has already been disposed');
    }
    _subscriptions.add(subscription);
  }

  /// Adds multiple StreamSubscriptions to the dispose bag
  void addAll(Iterable<StreamSubscription> subscriptions) {
    if (_isDisposed) {
      subscriptions.forEach((subscription) => subscription.cancel());
      throw StateError('DisposeBag has already been disposed');
    }
    _subscriptions.addAll(subscriptions);
  }

  /// Removes a StreamSubscription from the dispose bag without canceling it
  bool remove(StreamSubscription subscription) {
    return _subscriptions.remove(subscription);
  }

  /// Cancels all subscriptions and removes them from the bag
  Future<void> dispose() async {
    if (_isDisposed) return;

    _isDisposed = true;

    clearAll();
  }

  Future<void> clearAll() async {
    // Cancel all subscriptions
    await Future.wait(
      _subscriptions.map((subscription) => subscription.cancel()),
    );

    _subscriptions.clear();
  }

  /// Returns true if the bag has been disposed
  bool get isDisposed => _isDisposed;

  /// Returns the number of active subscriptions
  int get length => _subscriptions.length;
}
