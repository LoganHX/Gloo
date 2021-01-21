import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/components/SliderWidget.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import '../graphics/gloo_theme.dart';

class StudyDeckScreen extends StatefulWidget {
  //final List<Flashcard> flashcards;
  final Deck deck;

  const StudyDeckScreen({Key key, this.deck}) : super(key: key);
  @override
  _StudyDeckScreenState createState() => _StudyDeckScreenState();
}

class _StudyDeckScreenState extends State<StudyDeckScreen> {
  double slVal = 0;
  bool canEnd = false;
  String htmlData;
  bool isQuestion = true;
  CarouselController carouselController = CarouselController();
  var labels = {'answer': "Risposta", 'question': "Domanda"};

  Stream<List<Flashcard>> _getFlashcards() {
    final user = Provider.of<User>(context);
    return DatabaseService(uid: user.uid).flashcards(widget.deck.id);
  }

  void _updateFlashcards(Flashcard flashcard, int rating ) async {
    return DatabaseService(uid: Provider.of<User>(context, listen: false).uid).updateFlashcardRatingData(flashcard.id, widget.deck.id, rating);
  }

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
            onLongPress: (){
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
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Html(
                          style: {
                            "html": Style(
                              fontSize:
                                  text.length < 70 ? FontSize(20) : FontSize(16),
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
                duration: Duration(milliseconds: 400),

                child: SliderWidget( //todo controllare se è stato aggiustato il bug https://github.com/flutter/flutter/issues/28115
                onSelectedValue: (value) {
                  _updateFlashcards(flashcard, value);
                  carouselController.nextPage(duration: Duration(milliseconds: 512));
                },
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: (){
                //         print(item.toString());
                //         carouselController.nextPage();
                //       },
                //       child: Card(
                //         color: GlooTheme.nearlyWhite,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(50.0)),
                //         elevation: 10.0,
                //         child: Container(
                //           width: 50,
                //           height: 50,
                //           child: Center(
                //             child: Icon(
                //               Icons.thumb_down, //icona aggiungi carta
                //               color: GlooTheme.purple,
                //               size: 25,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     // GestureDetector(
                //     //   onTap: (){
                //     //     print(item.toString());
                //     //     carouselController.nextPage();
                //     //   },
                //     //   child: Card(
                //     //     color: GlooTheme.nearlyWhite,
                //     //     shape: RoundedRectangleBorder(
                //     //         borderRadius: BorderRadius.circular(50.0)),
                //     //     elevation: 10.0,
                //     //     child: Container(
                //     //       width: 50,
                //     //       height: 50,
                //     //       child: Center(
                //     //         child: Icon(
                //     //           Icons.sentiment_satisfied, //icona aggiungi carta
                //     //           color: GlooTheme.purple,
                //     //           size: 25,
                //     //         ),
                //     //       ),
                //     //     ),
                //     //   ),
                //     // ),
                //     SizedBox( width: MediaQuery.of(context).size.width*0.6-100,),
                //     GestureDetector(
                //       onTap: (){
                //         print(item.toString());
                //         carouselController.nextPage();
                //       },
                //       child: Card(
                //         color: GlooTheme.nearlyWhite,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(50.0)),
                //         elevation: 10.0,
                //         child: Container(
                //           width: 50,
                //           height: 50,
                //           child: Center(
                //             child: Icon(
                //               Icons.thumb_up, //icona aggiungi carta
                //               color: GlooTheme.purple,
                //               size: 25,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
             ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  Future<void> setData() async {
    //startStudyProcedure();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Flashcard>>(
        stream: _getFlashcards(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();
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
                                    snapshot.data[itemIndex],
                                    true,
                                    itemIndex),
                                back: _getCardWidget(
                                    snapshot.data[itemIndex],
                                    false,
                                    itemIndex),
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
                    //App bar da mettere anche nella pagina seguente
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top, left: 3),
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
                                    Navigator.pop(context);
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
}
