import 'dart:async';

class AsyncState<T> {
  T? _value;
  final StreamController<T?> _controller = StreamController<T?>.broadcast();

  T? get value => _value;

  Stream<T?> get stream => _controller.stream;

  Future<void> setAsyncState(Future<T> futureValue) async {
    T result = await futureValue;
    _value = result;
    _controller.add(_value);
  }

  void dispose() {
    _controller.close();
  }
}