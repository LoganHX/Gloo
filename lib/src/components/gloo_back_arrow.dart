import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlooBackArrow extends StatelessWidget {

  final Function(String string) onTap;

  const GlooBackArrow({Key key, this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Function onTap;
    if(this.onTap == null) onTap = (){Navigator.pop(context);};
    else onTap = this.onTap;
    return Padding(
      //App bar da mettere anche nella pagina seguente
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SizedBox(
        width: AppBar().preferredSize.height,
        height: AppBar().preferredSize.height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius:
            BorderRadius.circular(AppBar().preferredSize.height),
            child: Icon(
              Icons.arrow_back_ios, //ios
              color: GlooTheme.nearlyWhite,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
