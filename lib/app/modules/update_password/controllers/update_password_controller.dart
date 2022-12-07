import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController passLamaC = TextEditingController();
  TextEditingController passBaruC = TextEditingController();
  TextEditingController conPassBaruC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (passLamaC.text.isNotEmpty &&
        passBaruC.text.isNotEmpty &&
        conPassBaruC.text.isNotEmpty) {
      if (passBaruC.text == conPassBaruC.text) {
        try {
          //pertama mencoba sign in melalui email dan password user
          String emailUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: passLamaC.text);
          //jika sudah benar maka akan dieksekusi update password baru
          await auth.currentUser!.updatePassword(passBaruC.text);
          Get.back();
          Get.snackbar("Berhasil", "Password telah di ubah");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Terjadi Kesalahan", "Password yang di input salah");
          } else {
            Get.snackbar("Terjadi Kesalahan", "${e.code.toLowerCase()}");
          }
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat update password");
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat update password");
        }
      } else {
        Get.snackbar("Terjadi Kesalahan",
            "Password baru tidak sama dengan konfirmasi password");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua input harus di isi");
    }
  }
}
