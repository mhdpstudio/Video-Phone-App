import 'package:flutter/animation.dart';

class AppAnimation {
  AppAnimation._();

  // Duration
  static const fast = Duration(milliseconds: 180);

  static const normal = Duration(milliseconds: 280);

  static const slow = Duration(milliseconds: 420);

  static const extraSlow = Duration(milliseconds: 700);

  // Curves
  static const Curve defaultCurve = Curves.easeInOutCubic;

  static const Curve bounce = Curves.elasticOut;

  static const Curve smooth = Curves.easeOutExpo;

  static const Curve slide = Curves.fastOutSlowIn;
}