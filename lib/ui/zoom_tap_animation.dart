import 'dart:async';

import 'package:flutter/widgets.dart';

/// A widget that provides zoom animation effects on tap and long press interactions.
class ZoomTapAnimation extends StatefulWidget {
  const ZoomTapAnimation({
    super.key,
    required this.child,
    this.onTap,
    this.onLongTap,
    this.begin = 1.0,
    this.end = 0.93,
    this.beginDuration = const Duration(milliseconds: 20),
    this.endDuration = const Duration(milliseconds: 120),
    this.longTapRepeatDuration = const Duration(milliseconds: 100),
    this.beginCurve = Curves.decelerate,
    this.endCurve = Curves.fastOutSlowIn,
    this.enableLongTapRepeatEvent = false,
    this.behavior = HitTestBehavior.deferToChild,
  }) : assert(begin > end, 'Begin scale must be greater than end scale');

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final double begin;
  final double end;
  final Duration beginDuration;
  final Duration endDuration;
  final Duration longTapRepeatDuration;
  final Curve beginCurve;
  final Curve endCurve;
  final bool enableLongTapRepeatEvent;
  final HitTestBehavior behavior;

  @override
  State<ZoomTapAnimation> createState() => _ZoomTapAnimationState();
}

class _ZoomTapAnimationState extends State<ZoomTapAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _longPressTimer;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.endDuration,
      reverseDuration: widget.beginDuration,
      value: 1.0,
    );

    _animation = Tween<double>(
      begin: widget.end,
      end: widget.begin,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.beginCurve,
        reverseCurve: widget.endCurve,
      ),
    );
  }

  void _handleTapDown() {
    _isPressed = true;
    _controller.reverse();

    if (widget.enableLongTapRepeatEvent &&
        (widget.onLongTap != null || widget.onTap != null)) {
      _startLongPressTimer();
    }
  }

  void _handleTapUp() {
    _isPressed = false;
    _controller.forward();
    _cancelLongPressTimer();
  }

  void _startLongPressTimer() {
    _longPressTimer?.cancel();
    _longPressTimer = Timer.periodic(widget.longTapRepeatDuration, (timer) {
      if (!_isPressed) {
        _cancelLongPressTimer();
        return;
      }
      (widget.onLongTap ?? widget.onTap)?.call();
    });
  }

  void _cancelLongPressTimer() {
    _longPressTimer?.cancel();
    _longPressTimer = null;
  }

  void _handleLongPress() {
    if (!widget.enableLongTapRepeatEvent && widget.onLongTap != null) {
      widget.onLongTap!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onTap,
      onLongPress: _handleLongPress,
      child: Listener(
        behavior: widget.behavior,
        onPointerDown: (_) => _handleTapDown(),
        onPointerUp: (_) => _handleTapUp(),
        onPointerCancel: (_) => _handleTapUp(),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform.scale(
            scale: _animation.value,
            child: child,
          ),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelLongPressTimer();
    _controller.dispose();
    super.dispose();
  }
}
