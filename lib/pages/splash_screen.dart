import 'package:cinneman/core/style/colors.dart';
import 'package:flutter/material.dart';

import 'widgets/splashscreen_icon.dart';
import 'widgets/splashscreen_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SplashScreenIcon(),
            SplashScreenText(),
          ],
        ),
      ),
    );
  }
}
