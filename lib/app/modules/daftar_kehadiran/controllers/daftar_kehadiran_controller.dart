import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DaftarKehadiranController extends GetxController {
  final seminar = Get.arguments;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamKehadiran() async* {
    String uidS = seminar['id_s'];

    await firestore
        .collection("seminar")
        .doc(uidS)
        .collection("absensi")
        .snapshots();
  }

  Future<QuerySnapshot<Object?>> streamSeminar() async {
    String uidS = seminar['id_s'];
    CollectionReference seminars =
        firestore.collection("seminar").doc(uidS).collection("absensi");
    return seminars.get();
  }
}
