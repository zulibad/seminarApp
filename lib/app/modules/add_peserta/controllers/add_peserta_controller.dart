import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPesertaController extends GetxController {
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController no_telpC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPeserta() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;
        // memastikan sign in menggunakan akun admin   yang benar
        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);

        UserCredential pesertaCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        if (pesertaCredential.user != null) {
          String uid = pesertaCredential.user!.uid;
          //menambahkan ke cloud firestore
          firestore.collection("peserta").doc(uid).set({
            "nik": nikC.text,
            "name": nameC.text,
            "email": emailC.text,
            "no_telp": no_telpC.text,
            "uid": uid,
            "role": "peserta",
            "createdAt": DateTime.now()
                .toIso8601String(), //karena firebase tidak menyimpan tipe data date time, dirubah ke isoString
          });

          await pesertaCredential.user!.sendEmailVerification();

          //handle ketika menambah user/peserta admin tidak login sebagi user yang didaftarkan. tetapi sign in tetap sebgai admin
          await auth.signOut();
          //login kembali ke akun admin
          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );
          //menutup dialog
          Get.back();
          //kembali ke home
          Get.back();
          //snackbar berhasil
          Get.snackbar("Berhasil", "Peserta baru berhasil ditambahkan");
        }

        //handle kesalahan/eror dalam proses input
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password terlalu singkat");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan",
              "Peserta sudah terdaftar, tidak dapat menambahkan dengan email ini");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Admin tidak dapat login, password salah");
        } else {
          Get.snackbar("Terjadi Kesalahan", "${'e.code'}");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambah peserta");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password tidak benar");
    }
  }

  void addPeserta() async {
    if (nikC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        no_telpC.text.isNotEmpty) {
      // membuat dialog dengan tujuan mendapatkan password admin untuk relogin otomatis sebagai akun admin
      Get.defaultDialog(
          title: "Validasi Admin",
          content: Column(
            children: [
              Text("Masukan Password Sebagai Admin"),
              SizedBox(height: 15),
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
          actions: [
            OutlinedButton(onPressed: () => Get.back(), child: Text("CANCEL")),
            ElevatedButton(
                onPressed: () async {
                  await prosesAddPeserta();
                },
                child: Text("ADD")),
          ]);
    } else {
      Get.snackbar("Terjadi Kesalahan", "Form tidak boleh kosong");
    }
  }
}
