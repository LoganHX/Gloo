import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: GlooTheme.bgGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Padding(padding: EdgeInsets.zero,)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: GlooTheme.grey.withOpacity(0.8),
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(13.0),
                                        bottomLeft: Radius.circular(13.0),
                                        topLeft: Radius.circular(13.0),
                                        topRight: Radius.circular(13.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: TextFormField(
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: GlooTheme.nearlyWhite,
                                              ),
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Cerca deck pubblico...',
                                                border: InputBorder.none,
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 14,
                                                  letterSpacing: 0.2,
                                                  color: GlooTheme.nearlyWhite,
                                                ),
                                              ),
                                              onEditingComplete: () {},
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(Icons.search,
                                              color: GlooTheme.nearlyWhite),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Aggiungi un deck pubblico",
                          style: TextStyle(
                              color: GlooTheme.nearlyWhite, fontSize: 32),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: DropdownSearch<String>(
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 12.0,
                                ),
                                isCollapsed: true,
                                fillColor: GlooTheme.nearlyWhite,
                                filled: true,
                                //labelText: "Nome Corso",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: GlooTheme.purple),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: GlooTheme.nearlyWhite),
                                )),
                            mode: Mode.BOTTOM_SHEET,
                            showSearchBox: true,
                            popupBackgroundColor: GlooTheme.nearlyWhite,
                            showSelectedItem: false,
                            items: [
                              "Università degli studi di Salerno",
                              "Italia (Disabled)",
                              "Tunisia",
                              'Canada'
                            ],
                            hint: "Università degli studi di Salerno",
                            popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: print,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        DropdownSearch<String>(
                          dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 12.0,
                              ),
                              fillColor: GlooTheme.nearlyWhite,
                              filled: true,
                              isCollapsed: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: GlooTheme.purple),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: GlooTheme.nearlyWhite),
                              )),
                          mode: Mode.BOTTOM_SHEET,
                          showSearchBox: true,
                          popupBackgroundColor: GlooTheme.nearlyWhite,
                          showSelectedItem: false,
                          items: [
                            "DI - Dipartimento di Informatica",
                            "DIEM - Dipartimento di Ingegneria Elettronica e Matematica applicata",
                            "Tunisia",
                            'Canada'
                          ],
                          //label: "Scegli Dipartimento",
                          hint: "DI - Dipartimento di Informatica",
                          onChanged: print,
                        ),
                        SizedBox(height: 20.0),
                        DropdownSearch<String>(
                          dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 12.0,
                              ),
                              isCollapsed: true,
                              fillColor: GlooTheme.nearlyWhite,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: GlooTheme.purple),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: GlooTheme.nearlyWhite),
                              )),
                          mode: Mode.BOTTOM_SHEET,
                          showSearchBox: true,
                          popupBackgroundColor: GlooTheme.nearlyWhite,
                          showSelectedItem: false,
                          items: [
                            "DI - Dipartimento di Informatica",
                            "DIEM - Dipartimento di Ingegneria Elettronica e Matematica applicata",
                            "Tunisia",
                            'Canada'
                          ],
                          //label: "Scegli Corso",
                          hint: "---",
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: GlooTheme.purple,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Text(
                              "Cerca Deck",
                              style: TextStyle(color: GlooTheme.nearlyWhite),
                            ),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Expanded(child: Padding(padding: EdgeInsets.zero,)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  //App bar da mettere anche nella pagina seguente
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
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
          );
  }
}
