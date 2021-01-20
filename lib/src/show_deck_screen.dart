import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:alpha_gloo/src/study_deck_screen.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/components/bubble_indication_painter.dart';
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

  List<double> ratings;

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
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: GlooTheme.bgGradient,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 450.0
                ? MediaQuery.of(context).size.height
                : 450.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top * 0.5 +
                      AppBar().preferredSize.height,
                ),
                Text(
                  //"Enterprise Mobile Application Development",
                  widget.deck.course,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                    //letterSpacing: 0.27,
                    color: GlooTheme.nearlyWhite,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: _buildMenuBar(context),
                ),
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
                    SizedBox(
                      width: 50,
                    ), //todo si dovrebbe calcolare
                    Card(
                      color: GlooTheme.nearlyWhite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: Center(
                        child: FlatButton(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudyDeckScreen(deck: widget.deck)));
                            setState(() {
                              loading = false;
                            });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditorPage(deck: widget.deck)));
                      },
                      child: Card(
                        color: GlooTheme.purple.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        elevation: 10.0,
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Icon(
                              Icons.add, //icona aggiungi carta
                              color: GlooTheme.nearlyWhite,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                )
              ],
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
          )
        ],
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
                onPressed: _onShowFlashcardsButtonPress,
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

  // Widget getCardsUI({List<Flashcard> flashcards}) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       CardListView(
  //         deck: widget.deck,
  //         flashcards: flashcards,
  //         callBack: (Flashcard flashcard) {
  //           Navigator.pushNamed(context, '/answer', arguments: flashcard);
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildShowDeckScreen(BuildContext context) {
    //return getCardsUI(flashcards: flashcards);
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.54,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: GlooTheme.nearlyWhite,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Nome corso",
                    style:
                        TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
                  ),
                ),
                Text(
                  widget.deck.course,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: GlooTheme.purple),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Professore",
                    style:
                        TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
                  ),
                ),
                Text(
                  widget.deck.prof,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: GlooTheme.purple),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Anno Accademico",
                    style:
                        TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
                  ),
                ),
                Text(
                  "20/21",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: GlooTheme.purple),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Università",
                    style:
                        TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
                  ),
                ),
                Text(
                  widget.deck.university,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: GlooTheme.purple),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    final fakeValue = 71.0;
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
                        value: fakeValue,
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
                            fakeValue.toStringAsFixed(0) + '%',
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

  void _onShowFlashcardsButtonPress() {
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
