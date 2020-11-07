import 'package:alpha_gloo/src/deck_list_view.dart';
import 'package:flutter/material.dart';
import '../gloo_theme.dart';

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
            Container(
              height: MediaQuery.of(context).size.height*0.37, //altezza immagine
              child: Image.asset(
                  './assets/images/Collaboration-cuate-nearlyPurple.png'),
            ),
            Container(
              height: 0.05*MediaQuery.of(context).size.height,
              width: 0.8*MediaQuery.of(context).size.width,
              child: FittedBox(

                child: Text(
                  'Cosa vuoi imparare oggi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: GlooTheme.nearlyWhite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.5, //dimensione area scrolling
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: getDecksUI(),
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

  Widget getDecksUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0), //left era a 18 e right a 16
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
    Navigator.pushNamed(context, '/deck');
    /*
    Navigator.push<dynamic>(
      context,

      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ShowDeckScreen(),
      ),
    );*/
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
      padding: const EdgeInsets.only( left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: (MediaQuery.of(context).size.height ) * 0.08,
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
