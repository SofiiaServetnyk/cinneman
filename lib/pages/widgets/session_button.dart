import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/paddings_and_consts.dart';

class SessionSelectionButton extends StatelessWidget {
  String sessionTime;
  bool selected = false;
  Function()? onTap;

  SessionSelectionButton(
      {Key? key, required this.sessionTime, this.selected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: ButtonSize.sessionMinWidth,
        decoration: BoxDecoration(
            color: selected ? CustomColors.brown1 : CustomColors.yellow17,
            borderRadius: BorderRadius.circular(CustomBorderRadius.br)),
        child: Center(
          child: Text(sessionTime,
              textAlign: TextAlign.center, style: nunito.w500.s18.white),
        ),
      ),
    );
  }
}
