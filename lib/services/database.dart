import 'package:alpha_gloo/models/deck.dart';
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


  Future updateUserData(String name, String surname, String university, String course, String nickname) async {
    return await userCollection.document(uid).setData({
      "name": name,
      "surname": surname,
      "nickname": nickname,
      "university": university,
      "course": course,
    });
  }

  Future updateDeckData(String subject, String university, String course, String prof, String year) async {
    return await userCollection.document(uid).collection("decks").document(subject).setData({
      "university": university,
      "course": course,
      "prof": prof,
      "year": year,
    });
  }

  Future updateFlashcardData(String subject, String question, String answer) async {
    return await userCollection.document(uid).collection("decks").document(subject).collection("flashcards").document(question).setData({
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
    return userCollection.document(uid).collection("decks").snapshots().map(_deckListFromSnapshot);
  }

  Deck _deckFromSnapshot(DocumentSnapshot snapshot) {
    return Deck(
        university: snapshot.data['university'],
        course: snapshot.data['course'],
        prof: snapshot.data['prof'],
        year: snapshot.data['year']
    );
  }

  List<Deck> _deckListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Deck(
          university: doc.data['university'] ?? '',
          course: doc.data['course'] ?? '',
          prof: doc.data['prof'] ?? '',
          year: doc.data['year'] ?? ''
      );
    }).toList();
  }
  // // get flashcards stream
  // Stream<Deck> flashcards(String subject) {
  //   return userCollection.document(uid).collection("decks").document(subject).collection("flashcards").snapshots();
  //
  // }

}