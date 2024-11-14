import 'dart:async';

class ListState<T> {
  List<T> _list;
  final StreamController<List<T>> _controller = StreamController<List<T>>.broadcast();

  ListState(this._list);

  List<T> get list => _list;

  Stream<List<T>> get stream => _controller.stream;

  void addItem(T item) {
    _list.add(item);
    _controller.add(_list);
  }

  void removeItem(T item) {
    _list.remove(item);
    _controller.add(_list);
  }

  void resetList(List<T> defaultList) {
    _list = defaultList;
    _controller.add(_list);
  }

  void updateList() {
    _controller.add(_list);
  }

  void dispose() {
    _controller.close();
  }
}
