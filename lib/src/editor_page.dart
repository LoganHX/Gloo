import 'package:alpha_gloo/src/gloo_theme.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';

class EditorPage extends StatefulWidget {
  EditorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlooTheme.purple,
        title: Text("Edit Flashcard"),
        elevation: 0,
      ),
      backgroundColor: GlooTheme.nearlyWhite,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
                hint: "Your text here...",
                //value: "text content initial, if any",
                key: keyEditor,
                height: 400,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.blueGrey,
                      onPressed: (){
                        setState(() {
                          keyEditor.currentState.setEmpty();
                        });
                      },
                      child: Text("Reset", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 16,),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () async {
                        final txt = await keyEditor.currentState.getText();
                        setState(() {
                          // result = txt;
                          print(txt);
                        });
                      },
                      child: Text("Submit", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(result),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}