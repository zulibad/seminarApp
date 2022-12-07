import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seminar/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        //email verified
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            //memastikan dulu ke user ketika password nya masih default/bawaan minta untuk di rubah sebelum masuk ke halaman home
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText:
                  "Akun belum diverifikasi. Lakukan verifikasi diemail yang didaftarkan",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(), // untuk menutup kotak dialog
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!
                          .sendEmailVerification(); //async dan await untuk sesuatu yang harus menunggu tindakan dari sistem, makan pakai try n catch karena dikawatirkan eror
                      Get.back(); // menutup kotak dialog ketika user berhasil melakukan kirim ulang email
                      Get.snackbar(
                          "Berhasil", "Silahkan verifikasi diemail anda");
                    } catch (e) {
                      Get.snackbar("Terjadi Kesalahan",
                          "Tidak dapat mengirim email verifikasi. Coba beberapa saat lagi");
                    }
                  }, // untuk menutup dialog
                  child: Text("Kirim Ulang"),
                ),
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password salah");
        }
      } catch (e) {
        Get.snackbar(
            "Terjadi Kesalahan", "Tidak dapat login silahkan hubungi admin");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan Password harus diisi");
    }
  }
}
