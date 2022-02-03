import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';

class MyCustomRefreshIndicator extends StatelessWidget {
  final IndicatorController controller;
  final Widget child;

  const MyCustomRefreshIndicator({
    Key? key,
    required this.controller,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, _) => Stack(
        alignment: Alignment.topCenter,
        children: [
          if (!controller.isIdle)
            Positioned(
              top: 35.0 * controller.value,
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  value: !controller.isLoading
                      ? controller.value.clamp(0.0, 1.0)
                      : null,
                  color: getCustomTheme(context)?.loginButtonText,
                ),
              ),
            ),
          Transform.translate(
            offset: Offset(0, 100.0 * controller.value),
            child: child,
          ),
        ],
      ),
    );
  }
}
