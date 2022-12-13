import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DaftarPesertaController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
  //   String uid = auth.currentUser!.uid;

  //   yield* firestore.collection("peserta").doc(uid).snapshots();
  // }
  Future<QuerySnapshot<Object?>> User() async {
    CollectionReference users = firestore.collection("peserta");
    return users.get();
  }
}
