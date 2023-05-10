import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:flutter/material.dart';

class SplashScreenIcon extends StatelessWidget {
  const SplashScreenIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      PngIcons.cinnemanIcon,
      color: CustomColors.black,
      height: 100,
    );
  }
}
