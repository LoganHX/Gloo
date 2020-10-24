import 'package:alpha_gloo/src/card_list_view.dart';

import 'package:flutter/material.dart';
import '../main.dart';
import 'gloo_theme.dart';

class ShowDeckScreen extends StatefulWidget {
  @override
  _ShowDeckScreenState createState() => _ShowDeckScreenState();
}

class _ShowDeckScreenState extends State<ShowDeckScreen>
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
    final double tempHeight = MediaQuery
        .of(context)
        .size
        .height -
        (MediaQuery
            .of(context)
            .size
            .width / 1.2) +
        24.0;
    return Container(
      color: GlooTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.7, //form factor immagine
                  child: Image.asset('assets/images/main.png'),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery
                  .of(context)
                  .size
                  .width / 1.5) - 48.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [GlooTheme.purple.withOpacity(0.9), GlooTheme.nearlyPurple]),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: GlooTheme.purple.withOpacity(1),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 100.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints:
                      BoxConstraints(minHeight: infoHeight, maxHeight: 400), //questa non era così, modifica le dimensioni dello spazio in cui ci va ciò che è descritto in category_list_view.dart
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24.0, left: 16, right: 16, bottom: 0.0),
                            child: Text(
                              'EMAD',
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: GlooTheme.nearlyPurple,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '28 cards',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    color: GlooTheme.nearlyPurple,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '4.3 ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: GlooTheme.nearlyPurple,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: GlooTheme.nearlyPurple,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: getCategoryUI(),
                          ),



                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery
                  .of(context)
                  .size
                  .width / 1.2) - 137.0,
              right: 65,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: GlooTheme.nearlyPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Icon(
                        Icons.add, //icona aggiungi carta
                        color: GlooTheme.purple,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(

              top: (MediaQuery
                  .of(context)
                  .size
                  .width / 1.2) - 137,
              right: 10,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: GlooTheme.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Icon(
                        Icons.refresh, //icona ripeti deck
                        color: GlooTheme.nearlyPurple,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding( //App bar da mettere anche nella pagina seguente
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .padding
                  .top),
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

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CardListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ShowDeckScreen(),
      ),
    );
  }
/**
    Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
    txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
    txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
    txt = 'Basic UI';
    }
    return Expanded(
    child: Container(
    decoration: BoxDecoration(
    color: isSelected
    ? GlooTheme.nearlyBlue
    : GlooTheme.nearlyWhite,
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    border: Border.all(color: GlooTheme.nearlyBlue)),
    child: Material(
    color: Colors.transparent,
    child: InkWell(
    splashColor: Colors.white24,
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    onTap: () {
    setState(() {
    categoryType = categoryTypeData;
    });
    },
    child: Padding(
    padding: const EdgeInsets.only(
    top: 12, bottom: 12, left: 18, right: 18),
    child: Center(
    child: Text(
    txt,
    textAlign: TextAlign.left,
    style: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    letterSpacing: 0.27,
    color: isSelected
    ? GlooTheme.nearlyWhite
    : GlooTheme.nearlyBlue,
    ),
    ),
    ),
    ),
    ),
    ),
    ),
    );
    }*/

}