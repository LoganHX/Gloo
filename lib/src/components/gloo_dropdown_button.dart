import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlooDropdownButton extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String string) onChanged;
  const GlooDropdownButton({Key key, this.title, this.onChanged, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _glooDropdownButton(title: this.title, onChanged: this.onChanged);
  }

  Widget _glooDropdownButton(
      {String title, Function(String string) onChanged}) {
    return Container(
      height: 38,
      child: DropdownSearch<String>(
        //enabled: isCourse ? _courseVisibility : _departmentVisibility,
        onChanged: onChanged,
        mode: Mode.DIALOG,

        maxHeight: 450,
        hint: title,
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide:
                BorderSide(color: GlooTheme.nearlyWhite.withOpacity(0.8)),
          ),
          contentPadding: EdgeInsets.only(
            left: 24.0,
          ),
          isCollapsed: true,
          fillColor: GlooTheme.nearlyWhite.withOpacity(1),
          filled: true,
        ),
        //showClearButton: true,
        items: this.items,
        showSearchBox: false,
        searchBoxDecoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(12, 3, 3, 0),
          // labelText: "Search a country",
        ),
        popupTitle: Container(
          height: 42,
          decoration: BoxDecoration(
            color: GlooTheme.purple.withOpacity(1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: GlooTheme.nearlyWhite,
              ),
            ),
          ),
        ),
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
    );
  }
}
