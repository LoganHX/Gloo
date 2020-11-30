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
  int counter = 0;
  bool isQuestion = true;

  Widget cardWidget(String text, bool isQuestion) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          AppBar().preferredSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 0.075 *
                (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height),
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
              height: 0.018 *
                  (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height)),
          Container(
            height: 0.755 *
                (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height),
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
          SizedBox(
            height: 0.05 *
                (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height),
          ),
          Container(
            height: 0.1 *
                (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height),
            width: MediaQuery.of(context).size.width * 0.75,
            // top: MediaQuery.of(context).size.height * 0.88,
            // right: (MediaQuery.of(context).size.width * 0.2) / 2 +(-25), //todo il valore tra parentesi andrebbe calcolato
            child: AnimatedOpacity(
              opacity: isQuestion ? 0.0 : 1.0,
              duration: Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SliderWidget(
                  onSelectedValue: (value) {
                    print(value);
                    setState(() {
                      nextFlashcard();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var labels = {'answer': "Risposta", 'question': "Domanda"};

  @override
  void initState() {
    setData();
    super.initState();
  }

  // void toggleFlashcard() {
  //   if (isQuestion) {
  //     isQuestion = !isQuestion;
  //     htmlData = widget.flashcards[counter].answer;
  //     label = labels['answer'];
  //   } else {
  //     isQuestion = !isQuestion;
  //     htmlData = widget.flashcards[counter].question;
  //     label = labels['question'];
  //   }
  // }

  void nextFlashcard() {
    if (widget.flashcards.length == counter + 1) {
      Navigator.pop(
          context); //todo qua ci sarà il replace della route attuale con il push di una nuova route
      return;
    }
    counter += 1;
    isQuestion = true;
    htmlData = widget.flashcards[counter].question;
    //label = labels['question'];
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
    //label = labels['question'];
  }

  Future<void> setData() async {
    startStudyProcedure();
  }

  void startStudyProcedure() {
    htmlData = widget.flashcards.first.question;
    //label = labels['question'];
    isQuestion = true;
  }

  @override
  Widget build(BuildContext context) {
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
                    height: MediaQuery.of(context).padding.top +
                        AppBar().preferredSize.height,
                  ),
                  //Expanded(child: Padding(padding: EdgeInsets.zero,)),
                  //Text("////"),
                  CarouselSlider.builder(
                      itemCount: widget.flashcards.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return FlipCard(
                          front: cardWidget(
                              widget.flashcards[itemIndex].question, true),
                          back: cardWidget(
                              widget.flashcards[itemIndex].answer, false),
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
                              child: Row(children: [
                                Icon(
                                  Icons.edit,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Modifica"),
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
          ],
        ),
      ),
    );
  }
}
