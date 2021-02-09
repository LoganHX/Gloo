import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlooTextField extends StatelessWidget {
  final String title;
  final Function(String string) onChanged;
  final Icon icon;
  final TextEditingController controller;

  const GlooTextField({Key key, this.title, this.onChanged, this.icon, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(

      style: TextStyle(
        color: GlooTheme.purple,
      ),

      controller: this.controller,
      decoration: InputDecoration(

        labelStyle: TextStyle(
          color: GlooTheme.purple.withOpacity(0.65),
        ),
          suffixIcon: icon,
          fillColor: GlooTheme.nearlyWhite,
          filled: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: GlooTheme.purple),
            borderRadius: BorderRadius.circular(32),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: title,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: GlooTheme.nearlyPurple),
            borderRadius: BorderRadius.circular(32),
          )
      ),
      onChanged: this.onChanged,

    );
  }
}
