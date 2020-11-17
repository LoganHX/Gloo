import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alpha_gloo/models/user.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:alpha_gloo/services/database.dart';


class AddDeckScreen extends StatefulWidget {
  @override
  _AddDeckScreenState createState() => _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen> {

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

      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                GlooTheme.purple.withOpacity(0.9),
                GlooTheme.nearlyPurple
              ]),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text("Aggiungi un deck pubblico", style: TextStyle(color: GlooTheme.nearlyPurple, fontSize: 32),),
            SizedBox(height: 20.0),
            DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                label: "Menu mode",
                hint: "country in menu mode",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: print,
                selectedItem: "Brazil"),

            SizedBox(height: 20.0),

            SizedBox(height: 20.0),

            SizedBox(height: 20.0),

            SizedBox(height: 20.0),
            RaisedButton(
              color: GlooTheme.purple,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  "Crea Deck",
                  style: TextStyle(color: GlooTheme.nearlyPurple),
                ),
              ),
              onPressed: () {

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
    );
  }
}




