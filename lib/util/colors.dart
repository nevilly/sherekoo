import 'package:flutter/material.dart';

class OColors {
  //Sherekoo Color
  static Color secondary = const Color(0xff181A20);
  static Color appBarColor = const Color(0xff181A20);
  static Color primary = const Color(0xfff54b64); // Buttons Colors
  static Color primary2 = const Color(0xffff566e);
  static Color darkGrey = const Color(0xff4e586e);
  static Color darGrey = const Color(0xff242a38);
  static Color fontColor = const Color(0xffFFFFFF);

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

//font
const TextStyle title = TextStyle(fontSize: 16, color: Colors.white);

TextStyle appBarH = TextStyle(fontSize: 15, color: OColors.fontColor);
TextStyle header18 = TextStyle(
  fontSize: 18,
  color: OColors.fontColor,
  fontWeight: FontWeight.w400,
);

TextStyle header16 = TextStyle(fontSize: 16, color: OColors.fontColor);
TextStyle header15 = TextStyle(fontSize: 15, color: OColors.fontColor);
TextStyle header14 = TextStyle(fontSize: 14, color: OColors.fontColor);
TextStyle header13 = TextStyle(
  fontSize: 13,
  color: OColors.fontColor,
  fontWeight: FontWeight.w700,
);
TextStyle header12 = TextStyle(
    fontSize: 12, color: OColors.fontColor, fontWeight: FontWeight.w300);
TextStyle header10 = TextStyle(fontSize: 10, color: OColors.fontColor);
TextStyle header11 = TextStyle(fontSize: 11, color: OColors.fontColor);
TextStyle ef = TextStyle(color: OColors.fontColor); // empty font

//Button font
TextStyle bttnfontsec = TextStyle(fontSize: 10, color: OColors.secondary);
TextStyle bttnfontprimary = TextStyle(fontSize: 10, color: OColors.primary);
TextStyle bttnfontwhite = TextStyle(fontSize: 10, color: OColors.white);
TextStyle bttnfontblack = const TextStyle(fontSize: 10, color: Colors.black);

// Msg
String reqMsgInCrmdAdmin = 'Empty';
