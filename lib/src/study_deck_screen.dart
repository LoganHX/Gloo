import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/src/components/SliderWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/style.dart';
import '../graphics/gloo_theme.dart';

class StudyDeckScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  const StudyDeckScreen({Key key, this.flashcards}) : super(key: key);
  @override
  _StudyDeckScreenState createState() => _StudyDeckScreenState();
}

class _StudyDeckScreenState extends State<StudyDeckScreen> {
  String htmlData;
  String label;
  int counter = 0;
  bool isQuestion = true;

  Widget cardWidget(String text, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              letterSpacing: 0.27,
              color: GlooTheme.nearlyWhite,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.69,
            decoration: BoxDecoration(
              color: GlooTheme.nearlyPurple,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            padding: EdgeInsets.all(10),
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
                                text.length < 70 ? FontSize(21) : FontSize(17),
                            //todo si dovrebbe fare in modo che sotto una certa lunghezza del testo esso venga centrato e/o ridimensionato (posso usare htmlData.lenght)
                            textAlign: text.length < 70
                                ? TextAlign.center
                                : TextAlign.left,
                            //todo qui assumo che il testo delle domande sia sostanzialmente plain text e non html
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
      ],
    );
  }

  var labels = {'answer': "Risposta", 'question': "Domanda"};

  @override
  void initState() {
    setData();
    super.initState();
  }

  void toggleFlashcard() {
    if (isQuestion) {
      isQuestion = !isQuestion;
      htmlData = widget.flashcards[counter].answer;
      label = labels['answer'];
    } else {
      isQuestion = !isQuestion;
      htmlData = widget.flashcards[counter].question;
      label = labels['question'];
    }
  }

  void nextFlashcard() {
    if (widget.flashcards.length == counter + 1) {
      Navigator.pop(
          context); //todo qua ci sarà il replace della route attuale con il push di una nuova route
      return;
    }
    counter += 1;
    isQuestion = true;
    htmlData = widget.flashcards[counter].question;
    label = labels['question'];
  }

  void previousFlashcard() {
    //print(counter);
    if (counter == 0) {
      Navigator.pop(context);
      return;
    }
//todo non il massimo dell'eleganza
    counter -= 1;
    isQuestion = true;
    htmlData = widget.flashcards[counter].question;
    label = labels['question'];
  }

  Future<void> setData() async {
    startStudyProcedure();
  }

  void startStudyProcedure() {
    htmlData = widget.flashcards.first.question;
    label = labels['question'];
    isQuestion = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: GlooTheme.bgGradient,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0), //era 5 left  5 right
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Expanded(child: Padding(padding: EdgeInsets.zero,)),
                    CarouselSlider.builder(
                        itemCount: widget.flashcards.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return FlipCard(
                            front: cardWidget(
                                widget.flashcards[itemIndex].question,
                                "Domanda"),
                            back: cardWidget(
                                widget.flashcards[itemIndex].answer,
                                "Risposta"),
                          );
                        },

                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.9,
                          scrollDirection: Axis.horizontal,
                          enableInfiniteScroll: false,
                          disableCenter: true,
                        )),
                  ],
                ),
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
                          color: GlooTheme.nearlyPurple,
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
                        child: PopupMenuButton<IconButton>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<IconButton>>[
                            PopupMenuItem<IconButton>(
                              child: Row(children: [
                                Icon(
                                  Icons.delete,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Elimina flashcard"),
                              ]),
                            ),
                            PopupMenuItem<IconButton>(
                              //value: WhyFarther.harder,
                              child: Row(children: [
                                Icon(
                                  Icons.edit,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Modifica $label"),
                              ]),
                            ),
                          ],
                          child:
                              Icon(Icons.check, color: GlooTheme.nearlyWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   top: MediaQuery.of(context).size.height * 0.9,
            //   right: (MediaQuery.of(context).size.width * 0.2) / 2,
            //   child: AnimatedOpacity(
            //     opacity: isQuestion ? 0.0 : 1.0,
            //     duration: Duration(milliseconds: 400),
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 12.0),
            //       child: SliderWidget(
            //         onSelectedValue: (value) {
            //           print(value);
            //           setState(() {
            //             nextFlashcard();
            //           });
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
