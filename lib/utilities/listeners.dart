import 'dart:async';

typedef StateListenerCallback<T> = void Function(T value);

mixin StateListenerMixin<T> {
  final List<StreamSubscription<T>> _subscriptions = [];

  void addListener(Stream<T> stream, StateListenerCallback<T> onData) {
    final subscription = stream.listen(onData);
    _subscriptions.add(subscription);
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }
}

