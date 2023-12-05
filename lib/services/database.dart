import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user is currently signed in.');
      return;
    }

    // Add the writer's ID to the quizData map
    quizData['writerId'] = currentUser.uid;

    await FirebaseFirestore.instance
        .collection("Blog")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Blog").snapshots();
  }

  // getTitleData() async {
  //   return await FirebaseFirestore.instance.collection("Blog").snapshots();
  // }

  // getDesc() async {
  //   return await FirebaseFirestore.instance.collection("Blog").snapshots();
  // }
}
