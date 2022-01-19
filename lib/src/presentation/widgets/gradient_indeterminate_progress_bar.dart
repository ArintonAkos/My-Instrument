import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GradientIndeterminateProgressbar extends StatefulWidget {
  final double? height;
  final double? width;

  const GradientIndeterminateProgressbar({
    Key? key,
    this.height,
    this.width
  }) : super(key: key);

  @override
  _GradientIndeterminateProgressbarState createState() =>
      _GradientIndeterminateProgressbarState();
}

class _GradientIndeterminateProgressbarState
    extends State<GradientIndeterminateProgressbar>
    with TickerProviderStateMixin {

  late Animation<double> firstAnimation;
  late AnimationController firstAnimationController;
  late Animation<double> secondAnimation;
  late AnimationController secondAnimationController;

  double animationValue = 0;
  bool isFirstAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    firstAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    firstAnimation =
    CurvedAnimation(parent: firstAnimationController, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {
          if (!isFirstAnimationCompleted) {
            animationValue = firstAnimation.value * 360;
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isFirstAnimationCompleted = true;
          secondAnimationController.forward();
          firstAnimationController.reset();
        }
      });
    firstAnimationController.forward();

    /// Easing animation
    secondAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    secondAnimation = CurvedAnimation(
        parent: secondAnimationController, curve: Curves.easeOut)
      ..addListener(() {
        setState(() {
          if (isFirstAnimationCompleted) {
            animationValue = secondAnimation.value * 360;
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isFirstAnimationCompleted = false;
          firstAnimationController.forward();
          secondAnimationController.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 150,
      height: widget.height ?? 150,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showTicks: false,
          startAngle: animationValue,
          endAngle: animationValue + 350,
          radiusFactor: 0.5,
          axisLineStyle: AxisLineStyle(
            thickness: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            gradient: SweepGradient(
                colors: <Color>[
                  Theme.of(context).backgroundColor,
                  Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.loginButtonText ?? Colors.white                ,
                ],
                stops: const <double>[0.25, 1.0]),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    firstAnimationController.dispose();
    secondAnimationController.dispose();
    super.dispose();
  }
}