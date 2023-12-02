import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle Function({required double fontSize}) barInfoSheetHeaderStyle = ({required double fontSize}) => TextStyle(
    fontSize: fontSize,
    fontFamily: "Playfair_Display",
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.visible,
    color: Colors.black,
  );

  static TextStyle Function({required double fontSize}) emojiInText = ({required double fontSize}) => TextStyle(
    fontSize: fontSize,
    fontFamily: "AppleColorEmoji",
  );
}
