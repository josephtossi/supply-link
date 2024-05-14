import 'package:flutter/material.dart';

class Constant {
  static Color mainColor = const Color(0xff02062A).withOpacity(.2);
  static Color primaryColor = const Color(0xff1D243F).withOpacity(.97);
  static Color backgroundColor = const Color(0xffBF7FFF);
  static Color whiteColor = const Color(0xffC0CDFE);

  static TextStyle headline1 = TextStyle(
    fontSize: 15.0,
    color: whiteColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headline2 = TextStyle(
    fontSize: 12.0,
    color: whiteColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headline3 = TextStyle(
    fontSize: 15.0,
    color: whiteColor,
    fontWeight: FontWeight.w400,
  );

  static LinearGradient whiteLinearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xffE4E4E4).withOpacity(.2), Colors.transparent]);

  static List<Color> primaryGradient = [
    mainColor,
    primaryColor,
  ];
}
