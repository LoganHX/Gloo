import 'dart:math';

import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/src/components/gloo_back_arrow.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:alpha_gloo/src/study_deck_screen.dart';
import 'package:alpha_gloo/src/cloud_deck_screen.dart';
import 'package:alpha_gloo/src/views/details_view.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/components/bubble_indication_painter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ShowDeckScreen extends StatefulWidget {
  final Deck deck;
  ShowDeckScreen({this.deck});

  @override
  _ShowDeckScreenState createState() => new _ShowDeckScreenState();
}

class _ShowDeckScreenState extends State<ShowDeckScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Random randomGenerator = Random();
  List<double> ratings;
  Deck updatedDeck;
  Animation<double> animation;
  AnimationController animationController;
  PageController _pageController;
  bool loading = false;
  Color left = GlooTheme.nearlyWhite;
  Color right = GlooTheme.purple;

  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  Future<void> setData() async {
    updatedDeck == null
        ? updatedDeck = widget.deck
        : print("sono quiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
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

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: GlooTheme.bgGradient,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: GlooTheme.bgGradient,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top *
                            1.48), //todo trovare una misura esatta di questo per allineare il titolo alla freccia per tornare indietro
                    child: Center(
                      child: Text(
                        //"Enterprise Mobile Application Development",
                        updatedDeck.course,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          //letterSpacing: 0.27,
                          color: GlooTheme.nearlyWhite,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  _buildMenuBar(context),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = GlooTheme.purple;
                            left = GlooTheme.nearlyWhite;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = GlooTheme.nearlyWhite;
                            left = GlooTheme.purple;
                          });
                        }
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildStats(context),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildShowDeckScreen(context),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        color: GlooTheme.purple.withOpacity(0.9),
                        child: Icon(
                          Icons.cloud_upload,
                          color: GlooTheme.nearlyWhite,
                        ),
                        padding: EdgeInsets.all(13),
                        shape: CircleBorder(),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CloudDeckScreen(
                                        deck: widget.deck,
                                        isDownload: false,
                                      )));
                        },
                      ),
                      Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          color: GlooTheme.nearlyWhite,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 13),
                            child: Text(
                              "Studia Deck",
                              style: TextStyle(
                                  color: GlooTheme.purple, fontSize: 18),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudyDeckScreen(deck: updatedDeck)));
                            if (result != 0 && result != null) {
                              updatedDeck = await DatabaseService(
                                      uid: Provider.of<User>(context,
                                              listen: false)
                                          .uid)
                                  .getDeck(deckID: widget.deck.id);
                              setState(() {});
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                        ),
                      ),
                      RaisedButton(
                        color: GlooTheme.purple.withOpacity(0.9),
                        child: Icon(
                          Icons.note_add,
                          color: GlooTheme.nearlyWhite,
                        ),
                        padding: EdgeInsets.all(13),
                        shape: CircleBorder(),
                        onPressed: () async {
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditorPage(deck: updatedDeck)));

                          if (result == "Saved") {
                            updatedDeck = await DatabaseService(
                                    uid: Provider.of<User>(context,
                                            listen: false)
                                        .uid)
                                .getDeck(deckID: widget.deck.id);
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
            GlooBackArrow(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
    _pageController = PageController();
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: GlooTheme.nearlyWhite,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                // splashColor: Colors.transparent,
                // highlightColor: Colors.transparent,
                onPressed: _onShowStatsButtonPress,
                child: Text(
                  "Progressi",
                  style: TextStyle(
                    color: left,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                // splashColor: Colors.transparent,
                // highlightColor: Colors.transparent,
                onPressed: _onShowDetailsButtonPress,
                child: Text(
                  "Dettagli",
                  style: TextStyle(
                    color: right,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowDeckScreen(BuildContext context) {
    //return getCardsUI(flashcards: flashcards);
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetailsView(
            entries: {
              'Corso': updatedDeck.course,
              'Docente': updatedDeck.prof,
              'Anno Accademico': '20/21', //todo,
              'Università': updatedDeck.university,
            },
          )
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.54,
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(25)),
          //     color: GlooTheme.nearlyWhite,
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Nome corso",
          //           style:
          //               TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
          //         ),
          //       ),
          //       Text(
          //         updatedDeck.course,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //             fontSize: 24,
          //             fontWeight: FontWeight.w600,
          //             color: GlooTheme.purple),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Professore",
          //           style:
          //               TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
          //         ),
          //       ),
          //       Text(
          //         updatedDeck.prof,
          //         style: TextStyle(
          //             fontSize: 24,
          //             fontWeight: FontWeight.w600,
          //             color: GlooTheme.purple),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Anno Accademico",
          //           style:
          //               TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
          //         ),
          //       ),
          //       Text(
          //         "20/21",
          //         style: TextStyle(
          //             fontSize: 24,
          //             fontWeight: FontWeight.w600,
          //             color: GlooTheme.purple),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Università",
          //           style:
          //               TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
          //         ),
          //       ),
          //       Text(
          //         updatedDeck.university,
          //         style: TextStyle(
          //             fontSize: 24,
          //             fontWeight: FontWeight.w600,
          //             color: GlooTheme.purple),
          //       ),
          //       SizedBox(
          //         height: 25,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    double retainmentValue = 0;
    if (updatedDeck.retainedCards != null) {
      retainmentValue = updatedDeck.cardNumber != 0
          ? 100 * updatedDeck.retainedCards / updatedDeck.cardNumber
          : 0;
    }
    return Container(
      color: Colors.transparent,
      //padding: EdgeInsets.only(top: 23.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //   color: GlooTheme.nearlyWhite.withOpacity(0.8),
            //   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            // ),
            width: 280.0,
            height: 310.0,
            child: Container(
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: AxisLineStyle(
                      thickness: 1,
                      color: GlooTheme.nearlyWhite.withOpacity(1),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: 0.71*100,
                        width: 0.20,
                        color: GlooTheme.purple.withOpacity(0.85),
                        pointerOffset: 0.1,
                        cornerStyle: CornerStyle.bothCurve,
                        sizeUnit: GaugeSizeUnit.factor,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          positionFactor: 0.48,
                          angle: 90,
                          widget: Text(
                              (100*0.71).toStringAsFixed(0) + '%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: GlooTheme.purple.withOpacity(0.85)),
                          ))
                    ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _onShowStatsButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onShowDetailsButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}

class ChartData {
  ChartData(this.xVal, this.yVal, [this.radius]);
  final String xVal;
  final int yVal;
  final String radius;
}
