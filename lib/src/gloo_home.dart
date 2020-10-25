import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/deck_list_view.dart';
import 'package:alpha_gloo/src/card_list_view.dart';
import 'package:alpha_gloo/main.dart';
import 'package:flutter/material.dart';
import 'gloo_theme.dart';

class GlooHome extends StatefulWidget {
  @override
  _GlooHomeState createState() => _GlooHomeState();
}

class _GlooHomeState extends State<GlooHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: GlooTheme.nearlyPurple,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GlooTheme.purple.withOpacity(0.9),
              GlooTheme.nearlyPurple
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.55, //form factor immagine
              child: Image.asset(
                  './assets/images/Collaboration-cuate-nearlyPurple.png'),
            ),
            Text(
              'Cosa vuoi imparare oggi?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
                letterSpacing: 0.27,
                color: GlooTheme.nearlyWhite,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: getPopularCourseUI(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: getSearchBarUI(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: DeckListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ShowDeckScreen(),
      ),
    );
  }

  Widget getDeckUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DeckListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 8.0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 53,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: GlooTheme.grey.withOpacity(0.35),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: GlooTheme.nearlyPurple,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Ricerca un deck...',
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: GlooTheme.nearlyPurple,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: GlooTheme.nearlyPurple),
                    )
                  ],
                ),
              ),
            ),
          ),
          // const Expanded(
          //   child: SizedBox(),
          // )
        ],
      ),
    );
  }
}
