import 'dart:ui';

import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/src/cloud_deck_screen.dart';
import 'package:alpha_gloo/src/components/gloo_dropdown_button.dart';
import 'package:alpha_gloo/src/components/gloo_text_field.dart';
import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/views/deck_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';

class SearchDecksScreen extends StatefulWidget {
  final university;

  const SearchDecksScreen({Key key, this.university}) : super(key: key);
  @override
  _SearchDecksScreenState createState() => _SearchDecksScreenState();
}

class _SearchDecksScreenState extends State<SearchDecksScreen> {
  bool _optionsVisibility = false;
  String _choice = "";
  String _query = "";

  final _textController = TextEditingController();

  Widget build(BuildContext context) {
    //todo if come con loading per la "404"
    //todo fa una query ogni volta che cambio valore a _optionVisibility? controllare se lo stesso accade anche altrove
    final totalHeight = MediaQuery.of(context).size.height;
    final barHeight = AppBar().preferredSize.height + 25;
    final dividerHeight = 16.0;
    final scrollableHeight = totalHeight - barHeight - 60 - 50 - dividerHeight;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //color: GlooTheme.nearlyWhite,
            decoration: BoxDecoration(
              gradient: GlooTheme.bgGradient,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: barHeight,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          color: GlooTheme.nearlyWhite,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                style: TextStyle(
                                  color: GlooTheme.purple,
                                ),
                                controller: _textController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Color(
                                        0xff606066), //todo cambiare sto colore
                                  ),
                                  enabledBorder: InputBorder.none,
                                  // fillColor: Colors.transparent,
                                  // filled: true,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 24.0,
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: "Cerca deck pubblico",
                                ),
                              ),
                            ),
                            MaterialButton(
                              minWidth: 0,
                              shape: CircleBorder(),

                              splashColor: GlooTheme.nearlyWhite,
                              color: GlooTheme.purple,
                              onPressed: () {
                                _query = _textController.text;
                                print(_query);
                              },
                              child: Icon(
                                Icons.search,
                                color: GlooTheme.nearlyWhite,
                                size: 24,
                              ),
                            ),

                          ],
                        ),
                      ),
                      MaterialButton(
                        elevation: 0,
                        minWidth: 0,
                        shape: CircleBorder(),
                        splashColor: GlooTheme.nearlyWhite,
                        color: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            this._optionsVisibility =
                            !this._optionsVisibility;
                          });
                        },
                        child: Icon(
                          _optionsVisibility ? Icons.close : Icons.tune,
                          color: GlooTheme.nearlyWhite,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dividerHeight,
                  ),
                  Visibility(
                    visible: !_optionsVisibility,
                    child: Container(
                      height: 60,
                      child: Text(
                        'Trova il deck più adatto a te',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          letterSpacing: 0.27,
                          color: GlooTheme.nearlyWhite,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _optionsVisibility,
                    child: Container(
                      height: 60,
                      child: Column(

                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 21,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: GlooDropdownButton(
                                      items: [
                                        "Università degli studi di Salerno",
                                        "Università Federico II di Napoli",
                                        "Politecnico di Torino",
                                        "Politecnico di Milano",
                                        "Università di Modena e Reggio Emilia"
                                      ],
                                      title: 'Scegli Università',
                                      onChanged: (String s) {
                                        setState(() {
                                          _choice = s;
                                        });
                                      },
                                    )),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.367,
                                    child: GlooDropdownButton(
                                      items: [
                                        "★",
                                        "★★",
                                        "★★★",
                                        "★★★★",
                                        "★★★★★"
                                      ],
                                      title: 'Stelle',
                                      onChanged: (String s) {
                                        _choice = s;
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  _query != "" || _choice != ""
                      ? _getDeckListView(scrollableHeight)
                      : _getImage(scrollableHeight)
                ],
              ),
            ),
          ),
          Padding(
            //App bar da mettere anche nella pagina seguente
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.arrow_back_ios, //ios
                    color: GlooTheme.nearlyWhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDeckListView(height) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            height: height,
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
      ],
    );
  }

  Widget _getImage(height) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('./assets/images/search-cuate.png'),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Text(
              'Studia in maniera efficiente utilizzando deck prodotti da migliaia di altri studenti',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                letterSpacing: 0.27,
                color: GlooTheme.nearlyWhite,
              ),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
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
              getData: () {
                print("scelta" + _choice);
                return DatabaseService().searchDecks(university: this._choice);
              },
              callBack: (Deck deck) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CloudDeckScreen(
                            deck: deck,
                            isDownload: true,
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
