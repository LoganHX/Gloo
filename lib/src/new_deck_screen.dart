import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/shared/loading.dart';
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
    return loading ? Loading() : Scaffold(
      // backgroundColor: Colors.brown[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.brown[400],
      //   elevation: 0.0,
      //   title: Text("Sign up to Gloo"),
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text("Sign in"),
      //       onPressed: () {
      //         widget.toggleView();
      //       },
      //     )
      //   ],
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: GlooTheme.bgGradient,
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text("Crea Nuovo Deck", style: TextStyle(color: GlooTheme.nearlyWhite, fontSize: 32),),

                SizedBox(height: 20.0),
                TextFormField(

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(
                         12.0,
                      ),
                      isCollapsed: true,
                      fillColor: GlooTheme.nearlyWhite,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Nome Corso",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.purple),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.nearlyWhite ),
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Inserisci un corso" : null,
                  onChanged: (val) {
                    setState(() => course = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(
                        12.0,
                      ),
                      isCollapsed: true,
                      fillColor: GlooTheme.nearlyWhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.purple),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Nome Prof",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.nearlyWhite),
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Inserisci un prof" : null,
                  onChanged: (val) {
                    setState(() => prof = val);
                  },

                ),
                SizedBox(height: 20.0),
                TextFormField(

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(
                        12.0,
                      ),
                      isCollapsed: true,
                      fillColor: GlooTheme.nearlyWhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.purple),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Nome Università",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.nearlyWhite),
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Inserisci l'università" : null,
                  onChanged: (val) {
                    setState(() => university = val);
                  },

                ),
                SizedBox(height: 20.0),
                TextFormField(

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(
                        12.0,
                      ),
                      isCollapsed: true,
                      fillColor: GlooTheme.nearlyWhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.purple),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Anno",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.nearlyWhite),
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Inserisci un anno" : null,
                  onChanged: (val) {
                    setState(() => year = val);
                  },

                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: GlooTheme.purple,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Crea Deck",
                      style: TextStyle(color: GlooTheme.nearlyWhite),
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      await DatabaseService(uid: user.uid).createDeck(university, course, prof, year);
                      loading = false;
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 12.0,),
                Text(
                    error,
                    style: TextStyle(color: GlooTheme.purple, fontSize: 14.0)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




