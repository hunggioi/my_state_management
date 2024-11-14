import 'package:flutter/widgets.dart';

class StateBuilder<T> extends StatefulWidget {
  final Stream<T> stream;
  final T initialData;
  final Widget Function(BuildContext context, T data) builder;

  const StateBuilder({
    required this.stream,
    required this.initialData,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _StateBuilderState<T> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late T _data;

  @override
  void initState() {
    super.initState();
    _data = widget.initialData;
    widget.stream.listen((data) {
      setState(() {
        _data = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _data);
  }
}
