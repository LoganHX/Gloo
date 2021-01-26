import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/src/add_deck_screen.dart';
import 'package:alpha_gloo/services/wrapper.dart';
import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/src/new_deck_screen.dart';
import 'package:alpha_gloo/src/study_deck_screen.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/home/gloo_home.dart';
import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/deck.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: GlooTheme.nearlyPurple,
      systemNavigationBarDividerColor: GlooTheme.purple,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return MultiProvider(
      providers: [
        StreamProvider<User>(
          create: (_) => AuthService().user,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: GlooTheme.purple,
            secondaryHeaderColor: GlooTheme.nearlyPurple,
            accentColor: GlooTheme.nearlyWhite,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: GlooTheme.purple),
            ),
          ),
          home: Wrapper(),
          routes: {
            //'/':(context) => LoginScreen(),
            '/home': (context) => GlooHome(),
            '/deck': (context) => ShowDeckScreen(),
            '/study_deck': (context) => StudyDeckScreen(),
            '/editor': (context) => EditorPage(),
            '/profile': (context) => UserProfileScreen(),
            '/newDeck': (context) => NewDeckScreen(),
          }),
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
