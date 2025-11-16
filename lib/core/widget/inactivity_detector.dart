import 'dart:async';
import 'package:flutter/material.dart';

class InactivityDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onTimeout;
  final Duration timeoutDuration;

  const InactivityDetector({
    Key? key,
    required this.child,
    required this.onTimeout,
    this.timeoutDuration = const Duration(seconds: 30),
  }) : super(key: key);

  @override
  State<InactivityDetector> createState() => _InactivityDetectorState();
}

class _InactivityDetectorState extends State<InactivityDetector> {
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(widget.timeoutDuration, () {
      widget.onTimeout();
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _startTimer(),
      onPointerMove: (_) => _startTimer(),
      onPointerUp: (_) => _startTimer(),
      child: widget.child,
    );
  }
}