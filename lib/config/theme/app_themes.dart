import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Finlandica',
    appBarTheme: appBarTheme(),

  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color.fromARGB(0, 118, 118, 118)),
    titleTextStyle: TextStyle(color: Color.fromARGB(0, 118, 118, 118), fontSize: 18),
    
  );
}
