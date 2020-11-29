import 'package:flutter/material.dart';

class GlooTheme {
  GlooTheme._();

  static const Color purple = Color(0xFF5c53f8); //colore principale app
  static const Color nearlyPurple = Color(0xFFf1f1ff); //colore secondario app
  static const Color cardColor = Color(0xFFf1f1ff);
  static const Color grey = Color(0xFF6D72A6); //colore terziario app
  static const Color ice = Color(0xFFE9EFFF);
  static const Color nearlyWhite = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF2F4F75);

  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static var bgGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        GlooTheme.purple,
        GlooTheme.purple.withOpacity(0.75),
        GlooTheme.purple.withOpacity(0.6),
        //Color(0xFFAAAAAA),
      ]);

  //static const Color purple = Color(0xFFA1E7E5);
  //static const Color nearlyPurple = Color(0xFFb4f8c7);
  //static const Color yellow = Color(0xFFfbe7c6);
  static const Color yellow = Color(0xFFfbe7c6);
  //
  // static const TextTheme textTheme = TextTheme(
  //   headline4: display1,
  //   headline5: headline,
  //
  // );
  //
  // static const TextStyle display1 = TextStyle(
  //   // h4 -> display1
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.bold,
  //   fontSize: 36,
  //   letterSpacing: 0.4,
  //   height: 0.9,
  //   color: darkerText,
  // );
  //
  // static const TextStyle headline = TextStyle(
  //   // h5 -> headline
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.bold,
  //   fontSize: 24,
  //   letterSpacing: 0.27,
  //   color: darkerText,
  // );

  // static const TextStyle title = TextStyle(
  //   // h6 -> title
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.bold,
  //   fontSize: 16,
  //   letterSpacing: 0.18,
  //   color: darkerText,
  // );
  //
  // static const TextStyle subtitle = TextStyle(
  //   // subtitle2 -> subtitle
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.w400,
  //   fontSize: 14,
  //   letterSpacing: -0.04,
  //   color: darkText,
  // );
  //
  // static const TextStyle body2 = TextStyle(
  //   // body1 -> body2
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.w400,
  //   fontSize: 14,
  //   letterSpacing: 0.2,
  //   color: darkText,
  // );
  //
  // static const TextStyle body1 = TextStyle(
  //   // body2 -> body1
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.w400,
  //   fontSize: 16,
  //   letterSpacing: -0.05,
  //   color: darkText,
  // );
  //
  // static const TextStyle caption = TextStyle(
  //   // Caption -> caption
  //   fontFamily: 'WorkSans',
  //   fontWeight: FontWeight.w400,
  //   fontSize: 12,
  //   letterSpacing: 0.2,
  //   color: lightText, // was lightText
  // );
}
