import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlooCustomDialog extends StatelessWidget {

  final String image;
  final Map<String, Icon> entries;

  const GlooCustomDialog({Key key, this.image, this.entries}) : super(key: key);


  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlooTheme.nearlyWhite,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(32),
        // boxShadow: [
        //   BoxShadow(
        //     color: GlooTheme.nearlyPurple,
        //     blurRadius: 10.0,
        //     offset: const Offset(0.0, 10.0),
        //   ),
        // ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // To make the card compact
          children: <Widget>[

            Container(
                width: MediaQuery.of(context).size.width*0.7,
                child: Image.asset(image)),
            SizedBox(
              height: 4,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width*0.6,
              height: 45,
              child: RaisedButton.icon(
                label: Text(entries.keys.first),
                textColor: GlooTheme.nearlyWhite,
                icon: entries.values.first,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: GlooTheme.purple,
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width*0.6,
              height: 45,
              child: RaisedButton.icon(
                label: Text(entries.keys.last),
                textColor: GlooTheme.nearlyWhite,
                icon: entries.values.last,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: GlooTheme.purple,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
