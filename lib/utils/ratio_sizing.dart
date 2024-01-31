import 'package:flutter/material.dart';

class RatioSizing {
  RatioSizing();

  static double ratioW(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double ratioH(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }
}
