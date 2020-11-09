// import 'package:alpha_gloo/src/gloo_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:html_editor/html_editor.dart';
//
// class EditorPage extends StatefulWidget {
//   EditorPage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _EditorPageState createState() => _EditorPageState();
// }
//
// class _EditorPageState extends State<EditorPage> {
//   GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
//   String result = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: GlooTheme.purple,
//         title: Text("Modifica Flashcard"),
//         elevation: 0,
//         actions: <Widget>[
//           // IconButton(
//           //   icon: const Icon(Icons.cancel),
//           //   tooltip: 'Rimuovi flashcard',
//           //   onPressed: () {
//           //     setState(() {
//           //       keyEditor.currentState.setEmpty();
//           //     });
//           //   },
//           // ),
//           IconButton(
//             icon: const Icon(Icons.save),
//             tooltip: 'Salva flashcard',
//             onPressed: () async {
//               final txt = await keyEditor.currentState.getText();
//               setState(() {
//                 result = txt;
//                 print(result);
//               });
//             },
//           ),
//         ],
//       ),
//       backgroundColor: GlooTheme.nearlyWhite,
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               HtmlEditor(
//                 hint: "Inserisci qui il tuo testo...",
//                 //value: "text content initial, if any",
//                 key: keyEditor,
//                 height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight, //Altezza pagina - altezza status bar - altezza appbar
//               ),
//                Padding(
//                  padding: const EdgeInsets.only(top:8.0),
//                  child: Text(result),
//                )
//             ],
//           ),
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:alpha_gloo/src/Utils/my_zefyr_image_delegate.dart';

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
      appBar: AppBar(title: Text("Editor page")),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
            imageDelegate: MyAppZefyrImageDelegate(),
        ),
      ),
    );
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }
}