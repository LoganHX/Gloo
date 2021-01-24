import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';

class UploadDeckScreen extends StatefulWidget {
  final Deck deck;

  const UploadDeckScreen({Key key, this.deck}) : super(key: key);

  @override
  _UploadDeckScreenState createState() => _UploadDeckScreenState();
}

class _UploadDeckScreenState extends State<UploadDeckScreen> {
  Future<List<Flashcard>> _getFlashcards() {
    final user = Provider.of<User>(context, listen: false);
    return DatabaseService(uid: user.uid).getFutureFlashcards(widget.deck.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: GlooTheme.bgGradient,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.54,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: GlooTheme.nearlyWhite,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nome corso",
                            style: TextStyle(
                                fontSize: 18, color: GlooTheme.nearlyBlack),
                          ),
                        ),
                        Text(
                          widget.deck.course,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: GlooTheme.purple),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Professore",
                            style: TextStyle(
                                fontSize: 18, color: GlooTheme.nearlyBlack),
                          ),
                        ),
                        Text(
                          widget.deck.prof,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: GlooTheme.purple),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Anno Accademico",
                            style: TextStyle(
                                fontSize: 18, color: GlooTheme.nearlyBlack),
                          ),
                        ),
                        Text(
                          "20/21",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: GlooTheme.purple),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Università",
                            style: TextStyle(
                                fontSize: 18, color: GlooTheme.nearlyBlack),
                          ),
                        ),
                        Text(
                          widget.deck.university,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: GlooTheme.purple),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    width: MediaQuery.of(context).size.width/1.8,
                    child: Card(

                      color: GlooTheme.nearlyWhite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: Center(
                        child: FlatButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Upload Deck",
                              style: TextStyle(
                                  color: GlooTheme.purple, fontSize: 18),
                            ),
                          ),

                          onPressed: () async {
                            //todo si dovrebbe controllare che l'utente non posta 15 copie pubbliche del proprio deck

                            String id = await DatabaseService().createPublicDeck(university: widget.deck.university, course: widget.deck.course, prof: widget.deck.prof, year: widget.deck.year);
                            List<Flashcard> list =  await _getFlashcards();
                            list.forEach((element) {
                              DatabaseService().addPublicFlashcard(answer: element.answer , question: element.question, deckID: id);
                              print(element.answer);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
