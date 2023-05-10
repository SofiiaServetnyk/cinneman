import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

ButtonStyle textButtonStyle = TextButton.styleFrom(
  textStyle: nunito.w500.s18.black,
  minimumSize: const Size(ButtonSize.minWidth, ButtonSize.minHeight),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(CustomBorderRadius.br))),
  elevation: 0,
);
