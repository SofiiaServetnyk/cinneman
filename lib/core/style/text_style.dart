import 'dart:ui';

import 'package:cinneman/core/style/colors.dart';
import 'package:flutter/material.dart';

CustomTextStyle get nunito => Nunito();

class Nunito extends CustomTextStyle {
  Nunito()
      : super(fontFamily: 'Nunito', fontSize: 16.0, color: CustomColors.black);
}

class CustomTextStyle extends TextStyle {
  CustomTextStyle({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextLeadingDistribution? leadingDistribution,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
  }) : super(
          inherit: inherit,
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          leadingDistribution: leadingDistribution,
          textBaseline: textBaseline,
          height: height,
          locale: locale,
          foreground: foreground,
          background: background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          package: package,
        );

  //sizes
  CustomTextStyle get s12 => copyWith(fontSize: 12);
  CustomTextStyle get s14 => copyWith(fontSize: 14);

  CustomTextStyle get s16 => copyWith(fontSize: 16);
  CustomTextStyle get s18 => copyWith(fontSize: 18);
  CustomTextStyle get s20 => copyWith(fontSize: 20);
  CustomTextStyle get s22 => copyWith(fontSize: 22);
  CustomTextStyle get s24 => copyWith(fontSize: 24);
  CustomTextStyle get s26 => copyWith(fontSize: 26);
  // weights
  CustomTextStyle get w300 => copyWith(fontWeight: FontWeight.w300);

  CustomTextStyle get w400 => copyWith(fontWeight: FontWeight.w400);

  CustomTextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  CustomTextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  CustomTextStyle get w800 => copyWith(fontWeight: FontWeight.w800);

  // colors
  CustomTextStyle get paleBlack => copyWith(color: CustomColors.paleBlack);
  CustomTextStyle get white => copyWith(color: CustomColors.white);
  CustomTextStyle get grey => copyWith(color: CustomColors.grey);
  CustomTextStyle get brown1 => copyWith(color: CustomColors.brown1);
  CustomTextStyle get yellow1 => copyWith(color: CustomColors.yellow1);
  CustomTextStyle get black => copyWith(color: CustomColors.black);
  CustomTextStyle get yellow2 => copyWith(color: CustomColors.yellow2);

  @override
  CustomTextStyle copyWith(
      {bool? inherit,
      Color? color,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextBaseline? textBaseline,
      double? height,
      TextLeadingDistribution? leadingDistribution,
      Locale? locale,
      Paint? foreground,
      Paint? background,
      List<Shadow>? shadows,
      List<FontFeature>? fontFeatures,
      List<FontVariation>? fontVariations,
      TextDecoration? decoration,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
      String? debugLabel,
      String? fontFamily,
      List<String>? fontFamilyFallback,
      String? package,
      TextOverflow? overflow}) {
    return CustomTextStyle(
      inherit: inherit ?? this.inherit,
      color: this.foreground == null && foreground == null
          ? color ?? this.color
          : null,
      backgroundColor: this.background == null && background == null
          ? backgroundColor ?? this.backgroundColor
          : null,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }
}
