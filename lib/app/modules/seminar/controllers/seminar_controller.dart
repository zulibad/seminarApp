import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SeminarController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("peserta").doc(uid).snapshots();
  }

  Future<QuerySnapshot<Object?>> streamSeminar() async {
    CollectionReference seminars = firestore.collection("seminar");
    return seminars.get();
  }
}
