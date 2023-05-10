import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/input_formatter.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.limitTextInput,
      this.focusBorder,
      this.prefixIcon,
      this.style,
      this.maxLength,
      this.enabledBorder,
      this.maxWidth,
      this.hint,
      this.formatter,
      this.label,
      this.hintStyle,
      this.fillColor,
      required this.keyboardType,
      this.cursorColor,
      this.onChanged})
      : super(key: key);
  final String? hint;
  final String? label;
  final int? limitTextInput;
  final TextStyle? style;
  final TextInputType keyboardType;
  final Color? cursorColor;
  final Color? enabledBorder;
  final TextStyle? hintStyle;
  final int? maxLength;
  final Color? fillColor;
  final Color? focusBorder;
  final double? maxWidth;
  final Widget? prefixIcon;
  String? formatter;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: maxWidth ?? ButtonSize.minWidth,
          minHeight: ButtonSize.minHeight),
      child: TextFormField(
        style: (style ?? nunito.black.w400.s16),
        maxLength: maxLength,
        keyboardType: keyboardType,
        onChanged: onChanged,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]+'))
          else if (keyboardType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]+')),
          if (formatter != null)
            if (formatter == 'space') ...[
              CardNumberInputFormatter()
            ] else ...[
              CardMonthInputFormatter()
            ],
          LengthLimitingTextInputFormatter(limitTextInput),
        ],
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: fillColor ?? CustomColors.grey,
            hintText: hint ?? '',
            hintStyle: hintStyle ?? nunito.black.w400.s16,
            counter: const Offstage(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: Paddings.horizontal20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CustomBorderRadius.br),
              borderSide: focusBorder != null
                  ? BorderSide(color: focusBorder!)
                  : BorderSide(color: CustomColors.white),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: enabledBorder != null
                    ? BorderSide(color: enabledBorder!)
                    : BorderSide(color: CustomColors.yellow1),
                borderRadius: BorderRadius.circular(CustomBorderRadius.br))),
        cursorColor: cursorColor ?? CustomColors.black,
      ),
    );
  }
}


