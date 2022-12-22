import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //kasih bintang karena mode stream
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("peserta").doc(uid).snapshots();
  }

  Future<QuerySnapshot<Object?>> undangan() async {
    CollectionReference und = firestore.collection("seminar");
    return und.get();
  }

  Future<QuerySnapshot<Object?>> hadir() async {
    String uid = auth.currentUser!.uid;

    CollectionReference hdr =
        firestore.collection("peserta").doc(uid).collection("seminar");
    return hdr.get();
  }
}
