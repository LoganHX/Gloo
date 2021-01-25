import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/views/details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';

class CloudDeckScreen extends StatefulWidget {
  final Deck deck;
  final isDownload;

  const CloudDeckScreen({Key key, this.deck, this.isDownload})
      : super(key: key);

  @override
  _CloudDeckScreenState createState() => _CloudDeckScreenState();
}

class _CloudDeckScreenState extends State<CloudDeckScreen> {
  Future<List<Flashcard>> _getFlashcards() {
    final user = Provider.of<User>(context, listen: false);
    return DatabaseService(uid: user.uid).getFutureFlashcards(widget.deck.id);
  }

  Future<List<Flashcard>> _getPublicFlashcards() {
    final user = Provider.of<User>(context, listen: false);
    return DatabaseService().getFuturePublicFlashcards(widget.deck.id);
  }

  bool _visibility = false;
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    Function callback = widget.isDownload ? downloadDeck : uploadDeck;
    String label = widget.isDownload ? "Download" : "Upload";
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: GlooTheme.bgGradient,
        ),
        child: Stack(
          children: [
            _visibility
                ? loadingView()
                : detailsView(label: label, callback: callback),
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
      ),
    );
  }

  void uploadDeck() async {
    setState(() {
      _visibility = true;
    });

    DatabaseService db = DatabaseService();
    String id = await db.createPublicDeck(
        university: widget.deck.university,
        course: widget.deck.course,
        prof: widget.deck.prof,
        year: widget.deck.year);

    List<Flashcard> list = await _getFlashcards();

    list.forEach((element) {
      var i = 1;
      setState(() {
        _progress = i / list.length + 1;
      });
      i++;
      db.addPublicFlashcard(
          answer: element.answer, question: element.question, deckID: id);
      print(element.answer);
    });
  }

  void downloadDeck() async {
    setState(() {
      _visibility = true;
    });

    User user = Provider.of<User>(context, listen: false);
    DatabaseService db = DatabaseService(uid: user.uid);
    String id = await db.createDeck(
        university: widget.deck.university,
        course: widget.deck.course,
        prof: widget.deck.prof,
        year: widget.deck.year);

    List<Flashcard> list = await _getPublicFlashcards();
    print(list.first.question);
    list.forEach((element) {
      db.addFlashcard(
          answer: element.answer, question: element.question, deckID: id);
    });
  }

  Widget detailsView({String label, Function callback}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetailsView(
            entries: {
              'Nome Corso': widget.deck.course,
              'Docente': widget.deck.prof,
              'Anna Accademico': '20/21', //todo,
              'Università': widget.deck.university,
            },
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: GlooTheme.nearlyWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 13),
                  child: Text(
                    label + " Deck",
                    style: TextStyle(color: GlooTheme.purple, fontSize: 18),
                  ),
                ),
                onPressed: callback,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(GlooTheme.nearlyWhite),
              backgroundColor: GlooTheme.purple,
              strokeWidth: 10,
              value: _progress,
            ),
          ),
        ),
        SizedBox(height: 16,),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          color: GlooTheme.nearlyWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13),
            child: Text(
              "Ok",
              style: TextStyle(color: GlooTheme.purple, fontSize: 18),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
