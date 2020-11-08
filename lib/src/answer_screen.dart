import 'package:alpha_gloo/src/Utils/SliderWidget.dart';
import 'package:alpha_gloo/src/card_list_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'gloo_theme.dart';

/**todo questa route non dovrebbe esistere, serve solo come mock e per rendermi un po'
 * conto del tutto. DOBBIAMO FARE TUTTO DA QUESTION_SCREEN e usare le animazioni, se non
 * lo facciamo avremo problemi col context (non saremo più in grdo di andare avanti e indietro nell'app
 */
class AnswerScreen extends StatefulWidget {
  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

const htmlData = """

<h1>HTML Ipsum Presents</h1>
<img src="https://picsum.photos/200/200/" alt="Image">

<p><strong>Pellentesque habitant morbi tristique</strong> senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. <em>Aenean ultricies mi vitae est.</em> Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis.</p>

<h2>Header Level 2</h2>

<ol>
    <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>
    <li>Aliquam tincidunt mauris eu risus.</li>
</ol>
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Lorem_Ipsum_-_WYSIWYG_en_Latex_-_tekst_als_paden.svg/220px-Lorem_Ipsum_-_WYSIWYG_en_Latex_-_tekst_als_paden.svg.png" alt="Image">
<blockquote><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</p></blockquote>

<h3>Header Level 3</h3>

<ul>
    <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>
    <li>Aliquam tincidunt mauris eu risus.</li>
</ul>


""";

class _AnswerScreenState extends State<AnswerScreen>
    with TickerProviderStateMixin {
  //final double infoHeight = 360.0;
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
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Padding(
                        padding: EdgeInsets.all(0), //todo sotto il testo ho messo due Expanded per centrare il testo e tenere in basso lo slider, credo ci siano soluzioni migliori
                      )),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
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
                              onTap: () {},
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
                        //todo devo estrarre le parti comuni a Question e Answer per non avere codice duplicato

                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.69,),

                        decoration: BoxDecoration(
                          color: GlooTheme.nearlyPurple,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 2.0, bottom: 2.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Html(
                                    data: htmlData),
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
                      Expanded(child: Padding(
                        padding: EdgeInsets.all(0),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: SliderWidget(),
                      ),
                    ],
                  ),
                ),
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
                      color: GlooTheme.nearlyPurple,
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
