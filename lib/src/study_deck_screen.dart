import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/components/SliderWidget.dart';
import 'package:alpha_gloo/src/components/gloo_back_arrow.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../graphics/gloo_theme.dart';

class StudyDeckScreen extends StatefulWidget {
  final Deck deck;

  const StudyDeckScreen({Key key, this.deck}) : super(key: key);
  @override
  _StudyDeckScreenState createState() => _StudyDeckScreenState();
}

class _StudyDeckScreenState extends State<StudyDeckScreen> {
  int  _newlyRetained = 0;
  double slVal = 0;
  bool canEnd = false;
  String htmlData;
  bool isQuestion = true;
  CarouselController carouselController = CarouselController();
  var labels = {'answer': "Risposta", 'question': "Domanda"};

  List<int> changedValue;
  List<Flashcard> userFeedback;

  Stream<List<Flashcard>> _getFlashcards() {
    final user = Provider.of<User>(context);
    return DatabaseService(uid: user.uid).flashcards(widget.deck.id);
  }

  void _updateFlashcards(Flashcard flashcard, int rating) async {
    return DatabaseService(uid: Provider.of<User>(context, listen: false).uid)
        .updateFlashcardRatingData(flashcard.id, widget.deck.id, rating);
  }

  bool _loading = false;
  bool _operationConcluded = false;

  Widget _getCardWidget(Flashcard flashcard, bool isQuestion, int item) {
    String text = isQuestion ? flashcard.question : flashcard.answer;

    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          AppBar().preferredSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: FittedBox(
              child: Text(
                isQuestion ? labels['question'] : labels['answer'],
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
          SizedBox(
              height: 0.015 *
                  (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height)),
          GestureDetector(
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditorPage(deck: widget.deck, flashcard: flashcard)));
            },
            child: Container(
              height: 0.77 *
                  (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height),
              decoration: BoxDecoration(
                color: GlooTheme.nearlyWhite,
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              ),
              padding: EdgeInsets.all(12),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 2.0, left: 2.0, bottom: 2.0),
                  child: CupertinoScrollbar(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Html(
                          style: {
                            "html": Style(
                              fontSize: text.length < 70
                                  ? FontSize(20)
                                  : FontSize(16),
                              textAlign: text.length < 70
                                  ? TextAlign.center
                                  : TextAlign.left,
                              // qui assumo che il testo delle domande sia sostanzialmente plain text e non html
                            ),
                          },
                          onLinkTap: (url) {},
                          data: '$text',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
              height: 0.03 *
                  (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height)),
          Container(
            child: AnimatedOpacity(
              opacity: isQuestion ? 0.0 : 1.0,
              duration: Duration(milliseconds: 256),
              child: SliderWidget(
                //todo controllare se è stato aggiustato il bug https://github.com/flutter/flutter/issues/28115
                onSelectedValue: (value) {
                  if (flashcard.rating == null) {
                    Flashcard fl = flashcard;
                    fl.rating = value;
                    userFeedback[item] = fl;

                    if (value <= 3)
                      changedValue[item] = -1;
                    else if (value > 3)
                      changedValue[item] = 1;
                    else
                      changedValue[item] = 0;
                    return;
                  }
                  if (flashcard.rating != value) {
                    Flashcard fl = flashcard;
                    fl.rating = value;
                    userFeedback[item] = fl;
                  } else
                    userFeedback[item] = null;

                  if (flashcard.rating <= 3 && value > 3)
                    changedValue[item] = 1;
                  else if (flashcard.rating > 3 && value <= 3) {
                    changedValue[item] = -1;
                  } else
                    changedValue[item] = 0;

                  carouselController.nextPage(
                      duration: Duration(milliseconds: 512));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return loadingView(); //todo non credo sia appropriato, magari era meglio andare in un'altra schermata e caricare i valori aggiornati delle flashcards da là

    return StreamBuilder<List<Flashcard>>(
        stream: _getFlashcards(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();
          changedValue = List<int>(snapshot.data.length);
          userFeedback = List(snapshot.data.length);
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: GlooTheme.bgGradient,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).padding.top * 0.5 +
                              AppBar().preferredSize.height,
                        ),
                        //Expanded(child: Padding(padding: EdgeInsets.zero,)),
                        //Text("////"),
                        CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int itemIndex) {
                              return FlipCard(
                                front: _getCardWidget(
                                    snapshot.data[itemIndex], true, itemIndex),
                                back: _getCardWidget(
                                    snapshot.data[itemIndex], false, itemIndex),
                              );
                            },
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top -
                                  AppBar().preferredSize.height,
                              scrollDirection: Axis.horizontal,
                              enableInfiniteScroll: false,
                              disableCenter: true,
                              enlargeCenterPage: true,
                              pageSnapping: true,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
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
                                // isQuestion = false;
                                // counter = 0;
                                if (_loading)
                                  return Navigator.pop(
                                      context); //todo inserire valore di ritorno
                                else
                                  Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppBar().preferredSize.height,
                          height: AppBar().preferredSize.height,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(
                                    AppBar().preferredSize.height),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _loading = true;
                                    });
                                    int sum = 0;
                                    changedValue.forEach((element) {
                                      print("Element : " + element.toString());
                                      if (element != null) sum = sum + element;
                                    });

                                    _newlyRetained = sum;
                                    int i = 0;
                                    userFeedback.forEach((element) {
                                      if (element != null)
                                        _updateFlashcards(
                                            element, element.rating);
                                      else
                                        i++;
                                    });

                                    if (i == userFeedback.length)
                                      Navigator.pop(context);

                                    if (widget.deck.retainedCards != null)
                                      sum = sum + widget.deck.retainedCards;
                                    print("Sum: " + sum.toString());
                                    DatabaseService(
                                            uid: Provider.of<User>(context,
                                                    listen: false)
                                                .uid)
                                        .changeRetainedCardDeckData(
                                            deckID: widget.deck.id,
                                            retainedCards: sum);

                                    setState(() {
                                      _operationConcluded = true;
                                    });

                                  },
                                  icon: Icon(Icons.check,
                                      color: GlooTheme.nearlyWhite),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget loadingView() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: GlooTheme.bgGradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child:
                        Image.asset('./assets/images/mental_health-cuate.png')),
                Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        _operationConcluded
                            ? "Complimenti!\nHai aggiunto altre "+_newlyRetained.toString()+" flashcards a quelle che ricordi con sicurezza" //todo qualcosa di meglio
                            : "Stiamo caricando i tuoi risultati sul cloud",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          letterSpacing: 0.27,
                          color: GlooTheme.nearlyWhite,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _operationConcluded
                        ? RaisedButton(
                            shape: CircleBorder(),
                            color: GlooTheme.nearlyWhite,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 13),
                              child: Icon(Icons.done,
                                  size: 32, color: GlooTheme.purple),
                            ),
                            onPressed: () => Navigator.pop(context),
                          )
                        : Center(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 16),
                              child: SpinKitFadingGrid(
                                color: GlooTheme.nearlyPurple,
                                size: 50.0,
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
          GlooBackArrow(),
        ],
      ),
    );
  }
}
