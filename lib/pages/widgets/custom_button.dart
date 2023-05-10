import 'package:cinneman/core/style/custom_button_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends ElevatedButton {
  CustomButton({
    super.key,
    required VoidCallback onPressed,
    required Widget child,
    ButtonStyle? style,
  }) : super(onPressed: onPressed, child: child, style: buttonStyle);
}
