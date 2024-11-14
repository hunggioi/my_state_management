import 'dart:async';

class SimpleState<T> {
  T _value;
  final StreamController<T> _controller = StreamController<T>.broadcast();

  SimpleState(this._value);

  T get value => _value;

  Stream<T> get stream => _controller.stream;

  void setState(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _controller.add(_value); // Thông báo cho listener
    }
  }

  void resetState(T defaultValue) {
    _value = defaultValue;
    _controller.add(_value);
  }

  void dispose() {
    _controller.close();
  }
}
