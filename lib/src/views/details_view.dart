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
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 14),
      height: MediaQuery.of(context).size.height * 0.53, //TODO ha senso usare una misura basata sugli items, però ci sta il fatto delle righe
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

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      labels[index],
                      style:
                          TextStyle(fontSize: 18, color: GlooTheme.nearlyBlack),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      values[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: GlooTheme.purple),
                    ),
                    SizedBox(height: 8,)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
