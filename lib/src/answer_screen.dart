import 'package:alpha_gloo/src/Utils/SliderWidget.dart';
import 'package:alpha_gloo/src/card_list_view.dart';
import 'package:alpha_gloo/src/Utils/custom_slider_thumb_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../main.dart';
import 'gloo_theme.dart';

/**todo questa route non dovrebbe esistere, serve solo come mock e per rendermi un po'
 * conto del tutto. DOBBIAMO FARE TUTTO DA QUESTION_SCREEN e usare le animazioni, se non
 * lo facciamo avremo problemi col context (non saremo più in grdo di andare avanti e indietro nell'app
 */
class AnswerScreen extends StatefulWidget {
  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 360.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

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
                  padding:
                  EdgeInsets.only( left: 40, right: 40, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:18.0, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(

                              onTap: (){
                                Navigator.pushNamed(context, '/editor');
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: GlooTheme.nearlyPurple,
                                size: 22,
                              ),
                            ),
                            Text(
                              'Risposta',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: GlooTheme.nearlyWhite,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Icon(
                                  Icons.next_plan_rounded,
                                color: GlooTheme.nearlyPurple,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //todo devo fissare un'altezza massima
                        width: MediaQuery.of(context).size.width / 1.2,
                        constraints: BoxConstraints(maxHeight: 350),

                        decoration: BoxDecoration(
                          color: GlooTheme.nearlyPurple,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left:8.0, bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                        Navigator.pop(context);
                        },
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "Lorem Ipsum è un testo segnaposto utilizzato nel settore della tipografia e della stampa. Lorem Ipsum è considerato il testo segnaposto standard sin dal sedicesimo secolo, quando un anonimo tipografo prese una cassetta di caratteri e li assemblò per preparare un testo campione. È sopravvissuto non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.",
                                    style: TextStyle(
                                      color: GlooTheme.purple.withOpacity(1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Slider(
                      //   value: 40,
                      //   min: 0,
                      //   max: 80,
                      //   divisions: 4,
                      //
                      //   onChanged: (double value) {
                      //     print(value);
                      //   },
                      // )

                    ],
                  ),
                ),
              ),
            ),
            Positioned(
            top: 530,
            right: (MediaQuery.of(context).size.width) /9 - 10, //todo capire come centrare la cosa perché ho messo numeri a caso
              child: SliderWidget(),
            ),
            // Positioned(
            //   //top: (MediaQuery.of(context).size.width / 1.2) * 1.70 ,
            //   top: 20,
            //   right: (MediaQuery.of(context).size.width / 1.2) / 2,
            //   child: ScaleTransition(
            //     alignment: Alignment.center,
            //     scale: CurvedAnimation(
            //         parent: animationController, curve: Curves.fastOutSlowIn),
            //     child: Card(
            //       color: GlooTheme.nearlyPurple,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50.0)),
            //       elevation: 10.0,
            //       child: GestureDetector(
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //         child: Container(
            //           width: 50,
            //           height: 50,
            //           child: Center(
            //             child: Icon(
            //               Icons.arrow_upward_rounded, //
            //               color: GlooTheme.purple,
            //               size: 25,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: (MediaQuery.of(context).size.width / 1.2) - 137,
            //   right: 10,
            //   child: ScaleTransition(
            //     alignment: Alignment.center,
            //     scale: CurvedAnimation(
            //         parent: animationController, curve: Curves.fastOutSlowIn),
            //     child: Card(
            //       color: GlooTheme.purple,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50.0)),
            //       elevation: 10.0,
            //       child: Container(
            //         width: 50,
            //         height: 50,
            //         child: Center(
            //           child: Icon(
            //             Icons.refresh, //icona ripeti deck
            //             color: GlooTheme.nearlyPurple,
            //             size: 25,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
                      color: GlooTheme.nearlyBlack,
                    ),
                    onTap: () {
                      //todo è un trick, va risolto meglio
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getCardsUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CardListView(
          callBack: () {
            Navigator.pushNamed(context, '/answer');
          },
        ),
      ],
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => AnswerScreen(),
      ),
    );
  }
}
