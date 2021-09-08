import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

CustomTransition get slideTransition => CustomTransition(
  transitionDuration: Duration(milliseconds: 250),
  transitionBuilder: (context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).animate(animation),
        child: child,
      ),
    );
  }
);