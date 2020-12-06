import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/views/deck_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../graphics/gloo_theme.dart';

class GlooHome extends StatefulWidget {
  @override
  _GlooHomeState createState() => _GlooHomeState();
}

class _GlooHomeState extends State<GlooHome> {
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final imageHeight = (totalHeight * 0.38).roundToDouble();
    final titleHeight = (totalHeight * 0.08).roundToDouble();
    final barHeight = titleHeight -
        titleHeight; //eliminare la sottrazione in caso di necessità della Bar
    final scrollableHeight =
        totalHeight - imageHeight - titleHeight - barHeight;

    return Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: GlooTheme.purple.withOpacity(0.7),
              onPressed: () {
                Navigator.pushNamed(context, '/newDeck');
              },
              child: Icon(
                Icons.add,
                color: GlooTheme.nearlyWhite,
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                  top:
                      55.0), //todo studiare meglio come funziona Align per migliorare questo trick
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: GlooTheme.nearlyWhite.withOpacity(0.65),
                    child: CircleAvatar(
                      backgroundColor: GlooTheme.nearlyWhite.withOpacity(0.65),
                      backgroundImage: AssetImage('assets/images/carra.jpg'),
                      radius: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        //color: GlooTheme.nearlyWhite,
        decoration: BoxDecoration(
          gradient: GlooTheme.bgGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Container(
                height: imageHeight,
                child: Image.asset(
                    './assets/images/Collaboration-cuate-nearlyPurple.png'),
              ),
              Container(
                height: titleHeight,
                width: 0.8 * MediaQuery.of(context).size.width,
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
                    height: scrollableHeight, //dimensione area scrolling
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: getDecksUI(),
                        ),
                        // SizedBox(height: 16,)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: getBarUI(barHeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDecksUI() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 0, left: 16, right: 16, bottom: 0), //left era a 18 e right a 16
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: DeckListView(
              callBack: (Deck deck) {
                moveTo(deck);
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo(Deck deck) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShowDeckScreen(
            deck: deck,
          )),
    );
    //Navigator.pushNamed(context, '/deck');
  }

  Widget getBarUI(double barHeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: barHeight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: GlooTheme.grey.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: GlooTheme.nearlyWhite,
                      //size: 36.0,
                    ),
                    Icon(
                      Icons.search,
                      color: GlooTheme.nearlyWhite,
                      //size: 36.0,
                    ),
                    Icon(
                      Icons.explore,
                      color: GlooTheme.nearlyWhite,
                      //size: 36.0,
                    ),
                    Icon(
                      Icons.person,
                      color: GlooTheme.nearlyWhite,
                      //size: 36.0,
                    ),
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
