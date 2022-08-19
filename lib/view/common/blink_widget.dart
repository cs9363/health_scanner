import 'dart:async';

import 'package:flutter/material.dart';

class BlinkWidget extends StatefulWidget {
  final Widget widget;

  const BlinkWidget({Key? key, required this.widget}) : super(key: key);

  @override
  BlinkWidgetState createState() => BlinkWidgetState();
}

class BlinkWidgetState extends State<BlinkWidget> {
  bool _visible = true;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => _visible = !_visible),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: widget.widget,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      visible: _visible,
    );
  }
}
