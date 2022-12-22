import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailSeminarController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxString hasilQR = "data".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> scanQcode() async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      try {
        hasilQR.value = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.QR,
        );

        String uidSeminar = hasilQR.value;
        String uidUser = auth.currentUser!.uid;
        if (hasilQR != null) {
          CollectionReference<Map<String, dynamic>> seminarC = firestore
              .collection("seminar")
              .doc(uidSeminar)
              .collection("absensi");
          CollectionReference<Map<String, dynamic>> pesertaC = firestore
              .collection("peserta")
              .doc(uidUser)
              .collection("seminar");

          //..
          DateTime nowT = DateTime.now();
          DateTime nowD = DateTime.now();

          //..
          String time = DateFormat.jm().format(nowT);
          String date = DateFormat.yMd().format(nowD).replaceAll("/", "-");

          await seminarC.doc(uidUser).set({
            "uid": uidUser,
            "name": nameC.text,
            "email": emailC.text,
            "time": time.toString(),
            "date": date.toString(),
            "status": "hadir",
          });
          await pesertaC.doc(uidSeminar).set({
            "name": nameC.text,
            "time": time.toString(),
            "date": date.toString(),
            "status": "hadir",
          });
          Get.back();
          Get.back();
        }
        // Get.snackbar("Selamat Datang", "Absensi kehadiran telah berhasil",
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.green,
        //     colorText: Colors.white);
      } on PlatformException {}
    } else {
      //..
    }
  }

  void daftarHadir() async {
    Get.defaultDialog(
      title: "Validasi Peserta",
      content: Column(
        children: [
          Text("Masukan Nama dan Email yang terdaftar"),
          SizedBox(height: 15),
          TextField(
            controller: nameC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Nama Peserta",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: emailC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
      actions: [
        OutlinedButton(onPressed: () => Get.back(), child: Text("CANCEL")),
        ElevatedButton(
            onPressed: () async {
              await scanQcode();
            },
            child: Text("Hadir")),
      ],
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("peserta").doc(uid).snapshots();
  }
}
