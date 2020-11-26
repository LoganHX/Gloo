import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/src/components/SliderWidget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../graphics/gloo_theme.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({Key key}) : super(key: key);
  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  bool isQuestion = true;
  List<Flashcard> flashcards;
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

  void toggleFlashcard() {
    if (isQuestion) {
      isQuestion = false;
      htmlData = flashcards[counter].answer;
      label = "Risposta";
    } else {
      isQuestion = true;
      htmlData = flashcards[counter].question;
      label = "Domanda";
    }
  }

  void nextFlashcard() {
    counter += 1;
    isQuestion = true;
    htmlData = flashcards[counter].question;
    label = "Domanda";
  }

  Future<void> setData() async {
    animationController.forward();

    await Future<dynamic>.delayed(const Duration(milliseconds: 00));
    setState(() {
      opacity1 = 1.0;
    });

    await Future<dynamic>.delayed(const Duration(milliseconds: 00));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 00));
    setState(() {
      opacity3 = 1.0;
    });

    flashcards = ModalRoute.of(context).settings.arguments;
    htmlData = flashcards.first.question;
    label = "Domanda";
    isQuestion = true;
  }

  String htmlData;
  String label;
  int counter = 0;
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
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Icon(
                            //     Icons.next_plan_rounded,
                            //     color: GlooTheme.nearlyPurple,
                            //     size: 22,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            toggleFlashcard();
                          });
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
                          //Navigator.pop(context);
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
              child: Visibility(
                visible: !isQuestion,
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
