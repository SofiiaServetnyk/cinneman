import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

class SplashScreenText extends StatelessWidget {
  const SplashScreenText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('CINNEMAN',
          style: TextStyle(
            color: CustomColors.black,
            fontFamily: 'Morganite',
            fontSize: 72,
            letterSpacing: 1.2,
          )),
      Text(
        'The taste of art',
        style: nunito.s18.black,
      ),
    ]);
  }
}
