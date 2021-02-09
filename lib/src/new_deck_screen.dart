import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:alpha_gloo/src/components/gloo_back_arrow.dart';
import 'package:alpha_gloo/src/components/gloo_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/services/database.dart';

class NewDeckScreen extends StatefulWidget {
  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String course = "";
  String prof = "";
  String university = "";
  String year = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: GlooTheme.bgGradient,
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: AppBar().preferredSize.height,
                          ),
                          Text(
                            'Crea nuovo Deck',
                            style: TextStyle(
                              color: GlooTheme.nearlyWhite,
                              fontSize: 27.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          GlooTextField(
                            title: "Corso",
                            // validator: (val) =>
                            //     val.isEmpty ? "Inserisci un corso" : null,
                            onChanged: (val) {
                              setState(() => course = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          GlooTextField(
                            title: "Università",
                            // validator: (val) =>
                            //     val.isEmpty ? "Inserisci un corso" : null,
                            onChanged: (val) {
                              setState(() => university = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          GlooTextField(
                            title: "Professore/ssa",
                            // validator: (val) =>
                            //     val.isEmpty ? "Inserisci un corso" : null,
                            onChanged: (val) {
                              setState(() => prof = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          GlooTextField(
                            title: "Anno Accademico",
                            // validator: (val) =>
                            //     val.isEmpty ? "Inserisci un corso" : null,
                            onChanged: (val) {
                              setState(() => year = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              color: GlooTheme.nearlyWhite,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 13),
                                child: Text(
                                  "Crea Deck",
                                  style: TextStyle(
                                      color: GlooTheme.purple, fontSize: 18),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);

                                  await DatabaseService(uid: user.uid)
                                      .createDeck(
                                          deck: Deck(
                                    university: university,
                                    course: course,
                                    prof: prof,
                                    year: year,
                                    cardNumber: 0,
                                  ));
                                  loading = false;
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(error,
                              style: TextStyle(
                                  color: GlooTheme.purple, fontSize: 14.0)),
                        ],
                      ),
                    ),
                  ),
                ),
                GlooBackArrow(),
              ],
            ),
          );
  }
}
