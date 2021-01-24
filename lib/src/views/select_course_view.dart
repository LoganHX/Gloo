import 'dart:ui';

import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/src/components/gloo_dropdown_button.dart';
import 'package:alpha_gloo/src/search_decks_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SelectCourseView extends StatefulWidget {
  const SelectCourseView({Key key}) : super(key: key);

  @override
  _SelectCourseViewState createState() => _SelectCourseViewState();
}

class _SelectCourseViewState extends State<SelectCourseView> {
  final _formKey = GlobalKey<FormState>();
  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(4),
          children: <Widget>[
            Text(
              'Università',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: GlooTheme.nearlyWhite,
              ),
            ),

            Divider(),
            GlooDropdownButton(
              title: 'Università',
              onChanged: (String s) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchDecksScreen(university: "Università degli studi di Salerno",)));
              },

            ),
            Divider(),
            Text(
              'Corso',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: GlooTheme.nearlyWhite,
              ),
            ),
            Divider(),
            GlooDropdownButton(
              title: 'Corso',
              onChanged: (String s) {
              },
            ),
            Padding(padding: EdgeInsets.all(4)),
          ],
        ),
      ),
    );
  }


}
