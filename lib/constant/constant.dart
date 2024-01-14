import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Colors.black;
Color greyColor = Colors.grey;
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color lightGreyColor = Colors.grey.withOpacity(0.1);

TextStyle bigFontStyle() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle primaryFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle secondaryFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle greyFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: greyColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle lightGreyFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: lightGreyColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle whiteFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: whiteColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

List randomColor = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.brown,
  Colors.teal,
  Colors.cyan,
  Colors.lime,
  Colors.indigo,
  Colors.amber,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];
