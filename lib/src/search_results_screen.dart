import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/src/components/gloo_dropdown_button.dart';
import 'package:alpha_gloo/src/components/gloo_text_field.dart';
import 'package:alpha_gloo/src/show_deck_screen.dart';
import 'package:alpha_gloo/src/views/deck_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';

class SearchResultsScreen extends StatefulWidget {
  final university;

  const SearchResultsScreen({Key key, this.university}) : super(key: key);
  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _optionsVisibility = false;
  String _choice = "";
  final _textController = TextEditingController();

  Widget build(BuildContext context) {
    //todo if come con loading per la "404"
    //todo fa una query ogni volta che cambio valore a _optionVisibility? controllare se lo stesso accade anche altrove
    final totalHeight = MediaQuery.of(context).size.height;
    final imageHeight = (totalHeight * 0.38).roundToDouble();
    final titleHeight = (totalHeight * 0.08).roundToDouble();
    final barHeight = titleHeight;
    final scrollableHeight =
        totalHeight - imageHeight - titleHeight - barHeight;
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
                children: <Widget>[
                  Container(
                    height: imageHeight -
                        20, //todo metterla quando la situa è vuota e magari mettere a sistema con GlooHome
                    child: Image.asset('./assets/images/search-cuate.png'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: GlooTheme.nearlyWhite,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.69,
                          child: TextField(
                            style: TextStyle(
                              color: GlooTheme.purple,
                            ),
                            controller: _textController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black54, //todo cambiare sto colore
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
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: GlooTheme.purple,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 24,
                          width: 1,
                          color: GlooTheme.purple,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              this._optionsVisibility =
                                  !this._optionsVisibility;
                            });
                            print(_choice);
                          },
                          child: Container(
                            child: Icon(
                              _optionsVisibility
                                  ? Icons.close
                                  : Icons.settings_input_component,
                              color: GlooTheme.purple,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Visibility(
                    visible: _optionsVisibility,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 21,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: GlooDropdownButton(
                                    items: ["Università degli studi di Salerno", "Università Federico II di Napoli", "Politecnico di Torino", "Politecnico di Milano", "Università di Modena e Reggio Emilia"],
                                    title: 'Scegli Università',
                                    onChanged: (String s) {
                                      _choice = s;
                                      //print(_choice);
                                    },
                                  )),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: GlooDropdownButton(
                                    items: ["★", "★★", "★★★", "★★★★", "★★★★★"],
                                    title: 'Stelle',
                                    onChanged: (String s) {
                                      _choice = s;
                                      //print(_choice);
                                    },
                                  )),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Container(
                    height: titleHeight,
                    //width: 0.8 * MediaQuery.of(context).size.width,
                    child: Text(
                      'Risultati Ricerca',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        letterSpacing: 0.27,
                        color: GlooTheme.nearlyWhite,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height *
                            0.77, //dimensione area scrolling
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
                return DatabaseService()
                    .searchDecks(university: widget.university);
              },
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
}
