import 'package:flutter/material.dart';

enum TransitionDirection {
  left,
  right,
  top,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class SlideRoute extends PageRouteBuilder<dynamic> {
  SlideRoute({
    required this.page,
    required this.direction,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: _offset(direction),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.ease)).animate(animation),
            child: child,
          ),
        );

  final Widget page;

  final TransitionDirection direction;

  static Offset _offset(TransitionDirection direction) {
    switch (direction) {
      case TransitionDirection.left:
        return const Offset(-1.0, 0.0);
      case TransitionDirection.right:
        return const Offset(1.0, 0.0);
      case TransitionDirection.bottom:
        return const Offset(0.0, -1.0);
      case TransitionDirection.top:
        return const Offset(0.0, 1.0);
      case TransitionDirection.topLeft:
        return const Offset(-1.0, 1.0);
      case TransitionDirection.topRight:
        return const Offset(1.0, 1.0);
      case TransitionDirection.bottomLeft:
        return const Offset(-1.0, -1.0);
      case TransitionDirection.bottomRight:
        return const Offset(1.0, -1.0);

      default:
        return Offset.zero;
    }
  }
}
