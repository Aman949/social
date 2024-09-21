import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  //add Post
  Future<void> addPost(String message) {
    return posts.add({
      "userEmail": user!.email,
      "postMessage": message,
      "Timestamp": Timestamp.now()
    });
  }

  //read
  Stream<QuerySnapshot> getPost() {
    final postStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return postStream;    
  }
}
