import 'package:flutter/material.dart';

abstract class Paddings {
  // all
  static const EdgeInsets all5 = EdgeInsets.all(5.0);
  static const EdgeInsets all10 = EdgeInsets.all(10.0);
  static const EdgeInsets all15 = EdgeInsets.all(15.0);
  static const EdgeInsets all20 = EdgeInsets.all(20.0);
  static const EdgeInsets all24 = EdgeInsets.all(24.0);

  //horizontal
  static const double horizontal15 = 15.0;
  static const double horizontal20 = 20.0;

  //vertical
  static const double vertical5 = 5.0;
  static const double vertical20 = 20.0;
}

abstract class SizedBoxSize {
  static const double sbs5 = 5;
  static const double sbs10 = 10;
  static const double sbs15 = 15;
  static const double sbs20 = 20;
  static const double sbs25 = 25;
  static const double sbs30 = 30;
  static const double sbs40 = 40;
  static const double sbs45 = 45;
  static const double sbs50 = 50;
  static const double sbs75 = 75;
  static const double sbs100 = 100;
}

abstract class CustomBorderRadius {
  static const double br = 30;
}

abstract class ButtonSize {
  static const double sessionMinWidth = 75;
  static const double paymentMaxWidth = 150;
  static const double sessionMinHeight = 35;
  static const double minWidth = 325;
  static const double minHeight = 50;
}
