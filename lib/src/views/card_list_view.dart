import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';

class CardListView extends StatefulWidget {
  const CardListView({Key key, this.callBack, this.deck, this.flashcards})
      : super(key: key);
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

  Stream<List<Flashcard>> getData() {
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
        height: MediaQuery.of(context).size.height * 0.55,
        width: double.infinity,

        child: ListView.builder(
          padding:
              const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
          itemCount: widget.flashcards.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final int count =
                widget.flashcards.length > 10 ? 10 : widget.flashcards.length;
            final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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

class CardView extends StatefulWidget {
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
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  // var isQuestion = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                widget.callback(widget.flashcard);
              },
              child: FlipCard(
                front: _getCardWidget(widget.flashcard.question),
                back: _getCardWidget(widget.flashcard.answer),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getCardWidget(String text) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
            child: Container(
              height: 0.53*MediaQuery.of(context).size.height,
              width: 0.75*MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: GlooTheme.nearlyPurple,
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              ),
              padding: EdgeInsets.all(4),
              child: Center(
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 2.0, left: 2.0, bottom: 2.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Html(
                          style: {
                            "html": Style(
                              fontSize:
                              text.length < 70 ? FontSize(20) : FontSize(16),
                              //todo si dovrebbe fare in modo che sotto una certa lunghezza del testo esso venga centrato e/o ridimensionato (posso usare htmlData.lenght)
                              textAlign: text.length < 70
                                  ? TextAlign.center
                                  : TextAlign.left,
                              //todo qui assumo che il testo delle domande sia sostanzialmente plain text e non html
                            ),
                          },
                          onLinkTap: (url) {},
                          data: '$text',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }



/*
  Widget _getCardTemplate(String data) {
    return SizedBox(
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        left: 12,
                                        right: 12,
                                        bottom:
                                            0), //bottom per il pulsante modifica
                                    child: Center(
                                      child: Html(
                                        data: data,
                                        style: {
                                          "html": Style(
                                            fontSize: FontSize(16),
                                            textAlign: data.length > 100
                                                ? TextAlign.center
                                                : TextAlign.left,
                                          ),
                                        },
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
    );
  }*/
}
