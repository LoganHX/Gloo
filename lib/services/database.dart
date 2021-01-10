import 'package:alpha_gloo/models/deck.dart';
import 'package:alpha_gloo/models/flashcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // Change document name
  /*const firestore = firebase.firestore();
// get the data from 'name@xxx.com'
firestore.collection("users").doc("name@xxx.com").get().then(function (doc) {
    if (doc && doc.exists) {
        var data = doc.data();
        // saves the data to 'name'
        firestore.collection("users").doc("name").set(data).then({
            // deletes the old document
            firestore.collection("users").doc("name@xxx.com").delete();
        });
    }
});*/
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection("users");


  Future updateUserData(String name, String surname, String university, String department, String nickname) async {
    return await userCollection.document(uid).setData({
      "name": name,
      "surname": surname,
      "nickname": nickname,
      "university": university,
      "department": department,
    });
  }

  Future updateDeckData(String university, String course, String prof, String year) async {
    return await userCollection.document(uid).collection("decks").document(course).setData({ //todo non va bene mettere come nome del documento il campo course perché potrebbe essere modificato
      "university": university,
      "course": course,
      "prof": prof,
      "year": year,
    });
  }

  Future updateFlashcardData(String documentID, String course, String question, String answer, int rating) async {
    DateTime now =  DateTime.now();
    //print(userCollection.document(uid).collection("decks").document(course).collection("flashcards").document(documentID).toString());
    return await userCollection.document(uid).collection("decks").document(course).collection("flashcards").document(documentID).updateData({ //todo non va bene mettere come nome del documento il campo course perché potrebbe essere modificato
      // "question": question,
      // "answer": answer,
      "rating": rating,
      "date": DateTime(now.year, now.month, now.day),
    });
  }


  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }


  // get deck stream
  Stream<List<Deck>> get decks {
    return userCollection.document(uid).collection("decks").snapshots().map(_deckListFromSnapshot);
  }

  // get flashcards stream
  Stream<List<Flashcard>> flashcards(String course) {
    return userCollection.document(uid).collection("decks").document(course).collection("flashcards").snapshots().map(_flashcardListFromSnapshot);
  }

  Deck _deckFromSnapshot(DocumentSnapshot snapshot){
    return Deck(
        university: snapshot.data['university'],
        course: snapshot.data['course'],
        prof: snapshot.data['prof'],
        year: snapshot.data['year']
    );
  }
  Flashcard _flashcardFromSnapshot(DocumentSnapshot snapshot){
    snapshot.documentID;
    return Flashcard(
        id: snapshot.documentID,
        question: snapshot.data['question'],
        answer: snapshot.data['answer']
    );
  }

  List<Flashcard> _flashcardListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Flashcard(
          id: doc.documentID,
          question: doc.data['question'] ?? '',
          answer: doc.data['answer'] ?? '',
      );
    }).toList();
  }

  List<Deck> _deckListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Deck(
          id: doc.documentID,
          university: doc.data['university'] ?? '',
          course: doc.data['course'] ?? '',
          prof: doc.data['prof'] ?? '',
          year: doc.data['year'] ?? ''
      );
    }).toList();
  }

}