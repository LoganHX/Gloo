import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alpha_gloo/src/gloo_theme.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GlooTheme.purple.withOpacity(0.9),
              GlooTheme.nearlyPurple
            ]),),
      child: Center(
        child: SpinKitWave(
          color: GlooTheme.nearlyPurple,
          size: 50.0,
        ),
      ),
    );
  }
}
