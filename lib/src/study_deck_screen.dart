import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/src/components/SliderWidget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
      Navigator.pop(context); //todo qua ci sarà il replace della route attuale con il push di una nuova route
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [GlooTheme.purple, GlooTheme.nearlyPurple]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pushNamed(context, '/editor');
                            //   },
                            //
                            //   child: Icon(
                            //     Icons.edit_outlined,
                            //     color: GlooTheme.nearlyPurple,
                            //     size: 22,
                            //   ),
                            // ),
                            Text(
                              '$label',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                letterSpacing: 0.27,
                                color: GlooTheme.nearlyWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            toggleFlashcard();
                          });
                        },
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity < 0) {
                            setState(() {
                              nextFlashcard();
                            });
                          }
                          if (details.primaryVelocity > 0) {
                            setState(() {
                              previousFlashcard();
                            });
                          }
                        },
                        child: Container(

                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.69,
                          ),
                          decoration: BoxDecoration(
                            color: GlooTheme.nearlyPurple,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2.0, left: 2.0, bottom: 2.0),
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Html(
                                    data: '$htmlData',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          child: Icon(Icons.more_vert,
                              color: GlooTheme.nearlyWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.8,
              top: MediaQuery.of(context).size.height * 0.9,
              right: (MediaQuery.of(context).size.width * 0.2) / 2,
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
      ),
    );
  }
}
