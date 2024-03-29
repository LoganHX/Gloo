import 'dart:ui';
import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  final Map<String, String> entries;
  //todo sostituire le due liste con una key -> value

  const DetailsView({Key key, this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var labels = entries.keys.toList();
    var values = entries.values.toList();

    return Container(
      padding: EdgeInsets.only(bottom: 24, right: 7, left: 7),
      height: (105 * labels.length+1) < MediaQuery.of(context).size.height * 0.525
          ? (105 * labels.length+1).toDouble()
          : MediaQuery.of(context).size.height *
              0.525,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: GlooTheme.nearlyWhite,
      ),
      child: CupertinoScrollbar(
        child: ListView.builder(
            //separatorBuilder: (BuildContext context, int index) => SizedBox(height: 4,),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      labels[index],
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 16, color: GlooTheme.nearlyBlack),
                    ),

                    Text(
                      values[index],
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: GlooTheme.purple),
                    ),

                  ],
                ),
              );
            }),
      ),
    );
  }
}
