import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/views/details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool _operationConcluded = false;
  double _progress = 0; //todo da fare per bene o rimuovere
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
    String id = await db.createPublicDeck(deck: widget.deck);

    List<Flashcard> list = await _getFlashcards();

    list.forEach((element) async {
      var i = 1;
      setState(() {
        _progress = i / list.length + 1;
      });
      i++;

      await Future.delayed(const Duration(seconds: 2), () {});

      db.addPublicFlashcard(
          answer: element.answer, question: element.question, deckID: id);
      print(element.answer);
    });
    setState(() {
      _operationConcluded = true;
    });
  }

  void downloadDeck() async {
    setState(() {
      _visibility = true;
    });

    User user = Provider.of<User>(context, listen: false);
    DatabaseService db = DatabaseService(uid: user.uid);
    String id = await db.createDeck(deck: widget.deck);

    List<Flashcard> list = await _getPublicFlashcards();
    print(list.first.question);
    list.forEach((element) async {
      var i = 1;
      setState(() {
        _progress = i / list.length + 1;
      });
      i++;

      await Future.delayed(const Duration(seconds: 2), () {});
      db.addFlashcard(
          answer: element.answer, question: element.question, deckID: id);
    });

    setState(() {
      _operationConcluded = true;
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
            height: 32,
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
        Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.asset('./assets/images/Launching-cuate.png')),
        Column(
          children: [
            Text(
              _operationConcluded
                  ? "Operazione conclusa con successo"
                  : "Attendere prego",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
                letterSpacing: 0.27,
                color: GlooTheme.nearlyWhite,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            _operationConcluded
                ? RaisedButton(
                    shape: CircleBorder(),
                    color: GlooTheme.nearlyWhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 13),
                      child:
                          Icon(Icons.done, size: 32, color: GlooTheme.purple),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                : Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: SpinKitFadingGrid(
                        color: GlooTheme.nearlyPurple,
                        size: 50.0,
                      ),
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
