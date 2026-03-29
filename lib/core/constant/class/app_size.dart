import 'package:flutter/cupertino.dart';

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