import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection("users");
  final CollectionReference publicDecksCollection =
      Firestore.instance.collection("public_decks");

  Future updateUserData(String name, String surname, String university,
      String department, String nickname) async {
    return await userCollection.document(uid).setData({
      "name": name,
      "surname": surname,
      "nickname": nickname,
      "university": university,
      "department": department,
    });
  }

  Future<String> createDeck({Deck deck}) async {
    String id =
        userCollection.document(uid).collection("decks").document().documentID;
    userCollection.document(uid).collection("decks").document(id).setData({
      "university": deck.university,
      "course": deck.course,
      "prof": deck.prof,
      "year": deck.year,
      "cardNumber": deck.cardNumber,
    });

    return id;
  }

  Future<String> createPublicDeck({Deck deck}) async {
    String id = publicDecksCollection.document().documentID;

    publicDecksCollection.document(id).setData({
      "university": deck.university,
      "course": deck.course,
      "prof": deck.prof,
      "year": deck.year,
      "cardNumber": deck.cardNumber,
    });

    return id;
  }

  Future addPublicFlashcard(
      {String answer, String question, String deckID}) async {
    return await publicDecksCollection
        .document(deckID)
        .collection("flashcards")
        .document()
        .setData({
      "question": question,
      "answer": answer,
    });
  }

  Future updateDeckData(
      {String deckID,
      String course,
      String prof,
      String university,
      String year}) async {
   
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .updateData({
      "course": course,
      "prof": prof,
      "university": course,
      "year": prof,
    });
  }

  Future changeCardNumberDeckData({String deckID, int cardNumber}) async {
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .updateData({
      "cardNumber": cardNumber,
    });
  }

  Future changeRetainedCardDeckData({String deckID, int retainedCards}) async {
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .updateData({
      "retainedCards": retainedCards,
    });
  }

  Future updateFlashcardRatingData(
      String flashcardID, String deckID, int rating) async {
    DateTime now = DateTime.now();
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .collection("flashcards")
        .document(flashcardID)
        .updateData({
      "rating": rating,
      "date": DateTime(now.year, now.month, now.day),
    });
  }

  Future updateFlashcardData(
      String flashcardID, String deckID, String question, String answer) async {
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .collection("flashcards")
        .document(flashcardID)
        .updateData({
      "question": question,
      "answer": answer,
    });
  }

  Future addFlashcard({String deckID, String question, String answer}) async {
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .collection("flashcards")
        .document()
        .setData({
      "question": question,
      "answer": answer,
    });
  }

  Future createFlashcard(
      {String deckID, String question, String answer}) async {
    return await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .collection("flashcards")
        .document()
        .setData({
      "question": question,
      "answer": answer,
    });
  }

  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  // get deck stream
  Stream<List<Deck>> get decks {
    return userCollection
        .document(uid)
        .collection("decks")
        .snapshots()
        .map(_deckListFromSnapshot);
  }

  Stream<List<Deck>> searchDecks({String university}) {
    return publicDecksCollection
        .where("university", isEqualTo: university)
        .snapshots()
        .map(_deckListFromSnapshot);
  }

  // get flashcards stream
  Stream<List<Flashcard>> flashcards(String id) {
    // print("##########");
    // print(id);
    // print("##########");

    return userCollection
        .document(uid)
        .collection("decks")
        .document(id)
        .collection("flashcards")
        .snapshots()
        .map(_flashcardListFromSnapshot);
  }

  Future<List<Flashcard>> getFutureFlashcards(String id) async {
    QuerySnapshot snapshot = await userCollection
        .document(uid)
        .collection("decks")
        .document(id)
        .collection("flashcards")
        .getDocuments();

    return snapshot.documents
        .map((doc) => Flashcard(
              answer: doc.data['answer'],
              question: doc.data['question'],
            ))
        .toList();
  }

  Future<Deck> getDeck({String deckID}) async {
    DocumentSnapshot snapshot = await userCollection
        .document(uid)
        .collection("decks")
        .document(deckID)
        .get();

    return _deckFromSnapshot(snapshot, deckID);
  }

  Future<List<Flashcard>> getFuturePublicFlashcards(String id) async {
    QuerySnapshot snapshot = await publicDecksCollection
        .document(id)
        .collection("flashcards")
        .getDocuments();

    return snapshot.documents
        .map((doc) => Flashcard(
              answer: doc.data['answer'],
              question: doc.data['question'],
            ))
        .toList();
  }

  Deck _deckFromSnapshot(DocumentSnapshot snapshot, String deckID) {
    return Deck(
      id: deckID,
      university: snapshot.data['university'],
      course: snapshot.data['course'],
      prof: snapshot.data['prof'],
      year: snapshot.data['year'],
      cardNumber: snapshot.data['cardNumber'],
      retainedCards: snapshot.data['retainedCards'],
    );
  }

  Flashcard _flashcardFromSnapshot(DocumentSnapshot snapshot) {
    snapshot.documentID;
    return Flashcard(
        id: snapshot.documentID,
        question: snapshot.data['question'],
        answer: snapshot.data['answer']);
  }

  List<Flashcard> _flashcardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Flashcard(
        id: doc.documentID,
        question: doc.data['question'] ?? '',
        answer: doc.data['answer'] ?? '',
        rating: doc.data['rating'] ?? 0,
      );
    }).toList();
  }

  List<Deck> _deckListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Deck(
        id: doc.documentID,
        university: doc.data['university'] ?? '',
        course: doc.data['course'] ?? '',
        prof: doc.data['prof'] ?? '',
        year: doc.data['year'] ?? '',
        cardNumber: doc.data['cardNumber'] ?? 0,
        retainedCards: doc.data['retainedCards'] ?? 0,
      );
    }).toList();
  }
}
