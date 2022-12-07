import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seminar/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    // handle tidak isi pasword baru
    if (newPassC.text.isNotEmpty) {
      //handle user input password yang isinya password
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;
          //ketika berhasil, masuk ke halaman home
          await auth.currentUser!.updatePassword(
              newPassC.text); //perintah untuk pembaruan password
          //dibuat keluar dulu
          await auth.signOut();
          //masuk otomatais menggunakan password yang baru
          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);
          // proses ke halaman home
          Get.offAllNamed(Routes.HOME);
          //menggunakan doc dari firebase
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Terjadi Kesalahan",
                "Password terlalu lemah, setidaknya 6 karakter");
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Hubungi admin");
        }
      } else {
        Get.snackbar(
            "Terjadi Kesalahan", "Password baru tidak boleh 'password' !");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password baru harus diubah");
    }
  }
}
