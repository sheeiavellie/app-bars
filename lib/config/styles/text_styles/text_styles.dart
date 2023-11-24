import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle barInfoSheetHeaderStyle = TextStyle(
    fontSize: 18.0,
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
