import 'package:alpha_gloo/models/flashcard.dart';

class Deck {
  final String id;
  final String university;
  final String course;
  final String prof;
  final String year;
  final int cardNumber;
  final int retainedCards;

  Deck(
      {this.retainedCards,
      this.cardNumber,
      this.id,
      this.university,
      this.course,
      this.prof,
      this.year});
}
// class DeckWithCards{
//   //todo dovrebbe esserci una lista di Flashcards
//
//   Deck deck;
//   List<Flashcard> flashcards;
//
//   DeckWithCards({this.deck, this.flashcards});
// }
