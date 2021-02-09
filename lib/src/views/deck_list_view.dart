import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/components/gloo_custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeckListView extends StatefulWidget {
  const DeckListView({Key key, this.callBack, this.getData, this.showInfo})
      : super(key: key);
  final Function getData;
  final Function(Deck deck) callBack;
  final bool showInfo;
  @override
  _DeckListViewState createState() => _DeckListViewState();
}

class _DeckListViewState extends State<DeckListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Deck>>(
      stream: widget.getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return TransparentLoading();
        } else {
          //print(snapshot.data.last.course);
          return GridView(
            padding:
                const EdgeInsets.only(top: 8, left: 12, right: 8, bottom: 8),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: List<Widget>.generate(
              snapshot.data.length,
              (int index) {
                final int count = snapshot.data.length;
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                animationController.forward();
                return DeckView(
                  showInfo: widget.showInfo,
                  callback: widget.callBack,
                  deck: snapshot.data[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24.0,
              crossAxisSpacing: 32.0,
              childAspectRatio: 0.8,
            ),
          );
        }
      },
    );
  }
}

class DeckView extends StatelessWidget {
  const DeckView(
      {Key key,
      this.deck,
      this.animationController,
      this.animation,
      this.callback,
      this.showInfo})
      : super(key: key);

  final Function(Deck deck) callback;
  final bool showInfo;
  final Deck deck;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback(deck);
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return GlooCustomDialog(
                                        image:
                                            './assets/images/warning-cuate.png',
                                        entries: {
                                          "Modifica deck": Icon(Icons.edit),
                                          "Elimina Deck": Icon(Icons.delete),
                                        },
                                        functions: [() {}, () {}],
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: GlooTheme.cardColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          GlooTheme.cardColor.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: Offset(
                                          -5, 4), // changes position of shadow
                                    ),
                                  ],
                                  // border: new Border.all(
                                  //     color: GlooTheme.notWhite),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                          right: 16,
                                          bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: this.showInfo
                                                ? Row(
                                                    children: <Widget>[
                                                      Text(
                                                        //'${deck.year} ',
                                                        deck.university.length < 25
                                                            ? "4.2"
                                                            : "4.6",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 12,
                                                          letterSpacing: 0.0,
                                                          color:
                                                              GlooTheme.purple,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: GlooTheme.purple,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.zero),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  '${deck.year} ',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 1.0,
                                                    color: GlooTheme.purple,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: GlooTheme.purple,
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    bottom: 32),
                                                child: Center(
                                                  child: Text(
                                                    deck.course,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      letterSpacing: 0.27,
                                                      color: GlooTheme.purple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              this.showInfo
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16,
                                                              bottom: 0),
                                                      child: Center(
                                                        child: Text(
                                                          deck.university,
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12,
                                                            letterSpacing: 0.27,
                                                            color: GlooTheme
                                                                .purple,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.zero,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 280,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
