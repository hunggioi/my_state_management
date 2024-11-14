import 'dart:async';

class MapState<K, V> {
  Map<K, V> _map;
  final StreamController<Map<K, V>> _controller = StreamController<Map<K, V>>.broadcast();

  MapState(this._map);

  Map<K, V> get value => _map;

  Stream<Map<K, V>> get stream => _controller.stream;

  void updateValue(K key, V value) {
    _map[key] = value;
    _controller.add(_map); // Thông báo cập nhật
  }

  void removeValue(K key) {
    _map.remove(key);
    _controller.add(_map); // Thông báo xóa
  }

  void reset(Map<K, V> defaultMap) {
    _map = defaultMap;
    _controller.add(_map);
  }

  void dispose() {
    _controller.close();
  }
}
