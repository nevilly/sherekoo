import 'package:flutter/material.dart';

class OColors {
  ///
  ///Sherekoo Color
  ///Theme01
  ///
  static Color secondary = const Color(0xff181A20);
  static Color navBar = const Color(0xff181A20);
  static Color appBarColor = const Color(0xff181A20);
  static Color primary = const Color(0xfff54b64); // Buttons Colors
  static Color primary2 = const Color(0xffff566e);
  static Color darkGrey = const Color(0xff4e586e);
  static Color darGrey = const Color(0xff242a38);
  static Color fontColor = const Color(0xffFFFFFF);

  ///Them02

  // static Color secondary = Colors.white;
  // static Color navBar = const Color(0xff181A20);
  // static Color appBarColor = const Color(0xff181A20);
  // static Color primary = const Color(0xfff54b64); // Buttons Colors
  // static Color fontColor = const Color(0xff242a38);
  // static Color darkGrey = const Color(0xff4e586e);
  // static Color darGrey = const Color(0xff242a38);

  //Normal
  static Color sPurple = const Color(0xff8028ff);
  static Color sYelow = const Color(0xfffca01c);
  static Color white = const Color(0xffFFFFFF);
  static Color danger = Colors.red;
  static Color dangerFontColor = Colors.white;

  // END Sherekoo

  //Text Colors
  static Color titleColor = const Color(0xff352641);
  static Color subTitleColor = const Color(0xff352641);
  static Color textColor = const Color(0xff606060);
  static Color textDescriptionColor = const Color(0xff78849E);

  // appBar colors

  //Profile
  static Color profilePictureMainContainerColor = const Color(0xff8A56AC);

  //borders
  static Color borderColor = const Color(0xff261835);

  // Page colors Auth
  static Color introColor = const Color(0xff00AFCA);

  //buttons
  static Color buttonColor = const Color(0xffFDC50C);

  //SearchBackground
  static Color searchBackground = Colors.teal;

  //Others
  static Color transparent = Colors.transparent;
  static Color opacity = const Color(0xff646464);

  static Color whiteFade = const Color(0xffF6F6F6);
  static Color timeColor = const Color(0xff352641);
}

// convert color to hex func
Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

///
/// More Complex Short Var
///

Color fntClr = OColors.fontColor;
Color prmry = OColors.primary;
Color trans = OColors.transparent;
Color gry1 = OColors.darGrey;
Color osec = OColors.secondary;
Color odng = OColors.danger;
