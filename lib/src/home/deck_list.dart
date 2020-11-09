import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DeckList extends StatefulWidget {
  @override
  _DeckListState createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  @override
  Widget build(BuildContext context) {

    final decks = Provider.of<QuerySnapshot>(context);

    return Container(

    );
  }
}
