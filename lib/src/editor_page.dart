import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';
import 'package:alpha_gloo/src/components/flutter_summernote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  Deck deck;
  final Flashcard flashcard;
  EditorPage({Key key, this.title, this.deck, this.flashcard})
      : super(key: key);
  final String title;

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
  String result = "";
  Flashcard flashcard;

  bool toIncrement = false;

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null)
      flashcard = widget.flashcard;
    else {
      flashcard = Flashcard(answer: "", question: "", id: "");
      toIncrement = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlooTheme.purple,
        title: Text("Modifica Flashcard"),
        elevation: 0,
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.cancel),
          //   tooltip: 'Rimuovi flashcard',
          //   onPressed: () {
          //     setState(() {
          //       keyEditor.currentState.setEmpty();
          //     });
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Salva flashcard',
            onPressed: () async {
              DatabaseService db = DatabaseService(
                  uid: Provider.of<User>(context, listen: false).uid);

              flashcard = await keyEditor.currentState.getEditedFlashcard();

              if (widget.flashcard != null)
                db.updateFlashcardData(flashcard.id, widget.deck.id,
                    flashcard.question, flashcard.answer);
              else {
                db.createFlashcard(
                    deckID: widget.deck.id,
                    question: flashcard.question,
                    answer: flashcard.answer);
                db.changeCardNumberDeckData(
                    cardNumber: widget.deck.cardNumber + 1,
                    deckID: widget.deck.id);
              }

              Navigator.pop(context, "Saved");
            },
          ),
        ],
      ),
      backgroundColor: GlooTheme.nearlyWhite,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterSummernote(
                hint: "Inserisci qui il tuo testo...",
                //value: "text content initial, if any",
                flashcard: flashcard,
                key: keyEditor,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight, //Altezza pagina - altezza status bar - altezza appbar
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top:8.0),
              //   child: Text(result),
              // )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
