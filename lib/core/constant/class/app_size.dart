import 'package:flutter/material.dart';

extension NumberParsing on num {
  double w(BuildContext context) => this * MediaQuery.sizeOf(context).width;

  double h(BuildContext context) => this * MediaQuery.sizeOf(context).height;
}

extension SizeBoxExtension on num {
  SizedBox verticalSpace() {
    return SizedBox(height: toDouble());
  }

  SizedBox horizontalSpace() {
    return SizedBox(width: toDouble());
  }
}

/// Shared design tokens - use these instead of ad-hoc numbers so every
/// screen/widget stays visually consistent. New UI code should reach for
/// these first before hardcoding a radius/spacing/shadow value.
class AppRadius {
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 24;
  static const double xl = 28;
  static const double pill = 999;
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 14;
  static const double lg = 20;
  static const double xl = 28;
}

class AppShadow {
  /// Subtle card elevation - the default for most cards/containers.
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  /// Slightly stronger - for hero headers / primary CTAs.
  static List<BoxShadow> prominent = [
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 28,
      offset: const Offset(0, 14),
    ),
  ];
}
