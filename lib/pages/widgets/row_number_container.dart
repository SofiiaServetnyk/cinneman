import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

class RowNumberContainer extends StatelessWidget {
  int numberOfRows;

  RowNumberContainer({Key? key, required this.numberOfRows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.yellow17,
      ),
      child: Center(
          child: Text(numberOfRows.toString(), style: nunito.white.s12)),
    );
  }
}