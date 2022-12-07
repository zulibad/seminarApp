import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSeminarController extends GetxController {
  TextEditingController temaC = TextEditingController();
  TextEditingController pembicaraC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();
  TextEditingController waktuC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addSeminar() async {
    CollectionReference seminars = firestore.collection("seminar");

    if (temaC.text.isNotEmpty &&
        pembicaraC.text.isNotEmpty &&
        tanggalC.text.isNotEmpty &&
        lokasiC.text.isNotEmpty &&
        waktuC.text.isNotEmpty) {
      try {
        await seminars.add({
          "tema": temaC.text,
          "pembicara": pembicaraC.text,
          "lokasi": lokasiC.text,
          "date": tanggalC.text.toString(),
          "time": waktuC.text.toString(),
        });

        Get.back();
        Get.snackbar("Berhasil", "Jadwal seminar berhasil ditambahkan");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Gagal menambahkan jadwal seminar");
      }
    }
  }
}
