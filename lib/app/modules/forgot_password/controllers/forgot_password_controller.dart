import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar(
            "Berhasil", "Reset password berhasil dikirim ke email anda");
        Get.back();
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan",
            "Tidak dapat mengirim reset password ke email");
      }
    }
  }
}
