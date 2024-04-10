import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class CustomText extends StatelessWidget {
  @required
  String text;
  final double? minFontSize;
  final String? fontFamily;
  final double? fontSize;
  final Color? color;
  final TextAlign? align;
  final FontWeight? fontWeight;
  final double? letterspace;
  final Locale? locale;
  final TextOverflow? overflow;
  final Paint? foreground;
  final int? maxLine;
  TextDecoration? linethrough;
   CustomText({super.key,
    this.minFontSize,
    this.overflow,
    this.color,
    this.align,
    this.fontFamily,
    this.letterspace,
    this.fontSize,
    this.fontWeight,
    this.locale,
    this.foreground,
    this.maxLine,
    required this.text,
    this.linethrough
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      style: TextStyle(
        letterSpacing: letterspace,
        foreground: foreground,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: linethrough,
      ),
      text,
      maxLines: maxLine,
      textAlign: align,
    );
  }
}
