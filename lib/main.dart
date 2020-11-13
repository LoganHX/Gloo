import 'dart:io';
//importava pure app_theme
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/src/Utils/wrapper.dart';
import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/src/Utils/flutter_summernote.dart';
import 'package:alpha_gloo/src/answer_screen.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:alpha_gloo/src/question_screen.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/home/gloo_home.dart';
import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: GlooTheme.nearlyPurple,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: GlooTheme.purple,
          secondaryHeaderColor: GlooTheme.nearlyPurple,
          accentColor: GlooTheme.nearlyPurple,
        ),
        home: Wrapper(),
        routes: {
          //'/':(context) => LoginScreen(),
          '/home':(context) => GlooHome(),
          '/deck': (context) => ShowDeckScreen(),
          '/question': (context) => QuestionScreen(),
          '/answer' : (context) => AnswerScreen(),
          '/editor': (context) => EditorPage(),
          '/profile': (context) => UserProfileScreen(),
        }
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
