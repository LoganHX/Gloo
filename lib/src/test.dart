import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/study_deck_screen.dart';
import 'package:alpha_gloo/src/views/card_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../graphics/gloo_theme.dart';

class ShowDeckScreen extends StatefulWidget {
  final Deck deck;
  const ShowDeckScreen({Key key, this.deck}) : super(key: key);

  @override
  _ShowDeckScreenState createState() => _ShowDeckScreenState();
}

class _ShowDeckScreenState extends State<ShowDeckScreen>
    with TickerProviderStateMixin {
  bool loading = false;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  String count = "";

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  Stream<List<Flashcard>> _getFlashcards() {
    final user = Provider.of<User>(context);
    return DatabaseService(uid: user.uid).flashcards(widget.deck.course);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Flashcard>>(
      stream: _getFlashcards(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || loading) {
          return Loading();
        } else {
          return Container(
            color: GlooTheme.nearlyPurple.withOpacity(0.95),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: GlooTheme.bgGradient),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0,
                                        left: 42,
                                        right: 16,
                                        bottom: 0.0),
                                    child: Text(
                                      widget.deck.course,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: GlooTheme.nearlyPurple,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.length.toString() +
                                              ' cards',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 18,
                                            letterSpacing: 0.27,
                                            color: GlooTheme.nearlyPurple,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '4.3 ',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 18,
                                                  letterSpacing: 0.27,
                                                  color: GlooTheme.nearlyPurple,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: GlooTheme.nearlyPurple,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: getCardsUI(
                                        flashcards: snapshot.data.toList()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            ScaleTransition(
                              alignment: Alignment.center,
                              scale: CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn),
                              child: Card(
                                color: GlooTheme.nearlyPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                elevation: 10.0,
                                child: Center(
                                  child: FlatButton.icon(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      print("Tap bottone studio flashcards");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StudyDeckScreen(
                                                      flashcards:
                                                      snapshot.data)));
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.refresh, //icona ripeti deck
                                      color: GlooTheme.purple,
                                      size: 35,
                                    ),
                                    label: Text(
                                      "Studia Deck",
                                      style: TextStyle(
                                          color: GlooTheme.purple,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ScaleTransition(
                              alignment: Alignment.center,
                              scale: CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn),
                              child: Card(
                                color: GlooTheme.purple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                elevation: 10.0,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: Icon(
                                      Icons.add, //icona aggiungi carta
                                      color: GlooTheme.nearlyPurple,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: SizedBox(
                        width: AppBar().preferredSize.height,
                        height: AppBar().preferredSize.height,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                AppBar().preferredSize.height),
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
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getCardsUI({List<Flashcard> flashcards}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CardListView(
          deck: widget.deck,
          flashcards: flashcards,
          callBack: (Flashcard flashcard) {
            Navigator.pushNamed(context, '/answer', arguments: flashcard);
          },
        ),
      ],
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
}