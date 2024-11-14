class PerformanceMonitor {
  final List<int> _timestamps = [];

  void recordUpdate() {
    _timestamps.add(DateTime.now().millisecondsSinceEpoch);
  }

  double getAverageUpdateInterval() {
    if (_timestamps.length < 2) return 0.0;
    int totalInterval = 0;
    for (int i = 1; i < _timestamps.length; i++) {
      totalInterval += _timestamps[i] - _timestamps[i - 1];
    }
    return totalInterval / (_timestamps.length - 1);
  }

  void reset() {
    _timestamps.clear();
  }
}
