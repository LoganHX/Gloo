import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alpha_gloo/src/gloo_theme.dart';

class TransparentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [
      //         GlooTheme.purple.withOpacity(0.9),
      //         GlooTheme.nearlyPurple
      //       ]),),
      color: Colors.transparent,
      child: Center(
        child: SpinKitFadingGrid(
          color: GlooTheme.nearlyPurple,
          size: 50.0,
        ),
      ),
    );
  }
}
