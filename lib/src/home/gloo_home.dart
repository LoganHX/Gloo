import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/src/components/gloo_custom_dialog.dart';
import 'package:alpha_gloo/src/search_decks_screen.dart';
import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/views/deck_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';

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
              splashColor: GlooTheme.nearlyWhite,
              backgroundColor: GlooTheme.purple.withOpacity(1),
              onPressed: () {
                //Navigator.pushNamed(context, '/newDeck');

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GlooCustomDialog(
                        image: './assets/images/social-cuate.png',
                        entries: {
                          "Cerca deck pubblico": Icon(Icons.explore),
                          "Crea deck": Icon(Icons.create_new_folder_rounded),
                        },
                        functions: [
                          () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchDecksScreen()),
                            );
                          },
                          () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/newDeck');
                          }
                        ],
                      );
                    });

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             SearchDecksScreen()));
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
              // Container(
              //   child: Center(
              //     //child: getBarUI(barHeight),
              //   ),
              // ),
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

              showInfo: false,
              getData: () {
                final user = Provider.of<User>(context);
                return DatabaseService(uid: user.uid).decks;
              },
              callBack: (Deck deck) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowDeckScreen(
                            deck: deck,
                          )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
