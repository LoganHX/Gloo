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
              final txt = await keyEditor.currentState.getText();
              setState(() {
                // result = txt;
                print(txt);
              });
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
              HtmlEditor(
                hint: "Inserisci qui il tuo testo...",
                //value: "text content initial, if any",
                key: keyEditor,
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight, //Altezza pagina - altezza status bar - altezza appbar
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
