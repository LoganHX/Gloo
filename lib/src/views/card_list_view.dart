import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardListView extends StatefulWidget {
  const CardListView({Key key, this.callBack, this.deck, this.flashcards}) : super(key: key);

  final Function(Flashcard) callBack;
  final Deck deck;
  final List<Flashcard> flashcards;

  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Stream<List<Flashcard>> getData(){
    final user = Provider.of<User>(context);
    return DatabaseService(uid: user.uid).flashcards(widget.deck.course);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 0),
      child: Container(
        height:
            385, // todo l'altezza non deve essere fissa, ma proporzionata allo schermo usando context size
        width: double.infinity,

               child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: widget.flashcards.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = widget.flashcards.length > 10
                      ? 10
                      : widget.flashcards.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return CardView(
                    flashcard: widget.flashcards[index],
                    animation: animation,
                    animationController: animationController,
                    callback: (Flashcard flashcard) {
                      widget.callBack(flashcard);
                    },
                  );
                },
              ),

      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView(
      {Key key,
      this.flashcard,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final Function(Flashcard) callback;
  final Flashcard flashcard;
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
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback(flashcard);
              },
              child: SizedBox(
                width: 270,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: GlooTheme.nearlyPurple,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(

                                              padding: const EdgeInsets.only(
                                                  top: 1,
                                                  left: 12,
                                                  right: 12,
                                                  bottom:
                                                      0), //bottom per il pulsante modifica
                                              child: Center(
                                                child: Text(

                                                 flashcard.question,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,
                                                    color: GlooTheme.purple,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
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
