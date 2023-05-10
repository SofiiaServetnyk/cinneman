import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:flutter/material.dart';

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(ButtonSize.minWidth, ButtonSize.minHeight),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(CustomBorderRadius.br))),
    elevation: 0,
    backgroundColor: CustomColors.brown1,
    side: BorderSide(
      color: CustomColors.yellow1,
      width: 1.0,
    ));
