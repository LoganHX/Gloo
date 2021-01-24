import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/editor_page.dart';
import 'package:alpha_gloo/src/search_decks_screen.dart';
import 'package:alpha_gloo/src/study_deck_screen.dart';
import 'package:alpha_gloo/src/views/select_course_view.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/components/bubble_indication_painter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AddDeckScreen extends StatefulWidget {
  final Deck deck;
  AddDeckScreen({this.deck});

  @override
  _AddDeckScreenState createState() => new _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();

  bool _enabledDepartmentBtn = false;
  bool _enabledCourseBtn = false;

  Animation<double> animation;
  AnimationController animationController;
  PageController _pageController;
  bool loading = false;
  Color left = GlooTheme.nearlyWhite;
  Color right = GlooTheme.purple;

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
                  "Crea o adotta un deck",
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
                        child: SelectCourseView(),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SelectCourseView(),
                      ),
                    ],
                  ),
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
                onPressed: _onShowSearchDeckButtonPress,
                child: Text(
                  "Cerca Deck",
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
                onPressed: _onShowNewDeckButtonPress,
                child: Text(
                  "Nuovo Deck",
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

  // Widget _buildSearchDeck(BuildContext context) {
  //   final user = Provider.of<User>(context);
  //   String university;
  //   String course;
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(25),
  //     child: Form(
  //       key: _formKey,
  //       autovalidateMode: AutovalidateMode.onUserInteraction,
  //       child: ListView(
  //         padding: EdgeInsets.all(4),
  //         children: <Widget>[
  //           ///Menu Mode with no searchBox
  //           Text(
  //             'Università',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 24,
  //               color: GlooTheme.nearlyWhite,
  //             ),
  //           ),
  //           Divider(),
  //
  //           ///BottomSheet Mode with no searchBox
  //           _glooDropdownButton(title: 'Università',),
  //           Divider(),
  //           Text(
  //             'Dipartimento',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 24,
  //               color: GlooTheme.nearlyWhite,
  //             ),
  //           ),
  //           Divider(),
  //           _glooDropdownButton(
  //               title: 'Dipartimento',),
  //
  //           Divider(),
  //           Text(
  //             'Corso',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 24,
  //               color: GlooTheme.nearlyWhite,
  //             ),
  //           ),
  //           Divider(),
  //           _glooDropdownButton(title: 'Corso',),
  //           Padding(padding: EdgeInsets.all(4)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //



  void _onShowSearchDeckButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onShowNewDeckButtonPress() {
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
