import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nikC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController no_telpC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  XFile? image;

  //Ambil gambar dari galery
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   print(image!.name);
    //   print(image!.name.split(".").last); // untuk mengambil extensi tipe image
    //   print(image!.path);
    // } else {
    //   print(image);
    // }
    update(); //untuk update gambar yang dipilih dari gallery
  }

  //tangkap uid dari button view menggunakan String uid
  Future<void> updateProfile(String uid) async {
    //memastikan field tidak ksong
    if (nikC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        no_telpC.text.isNotEmpty) {
      try {
        Map<String, dynamic> data = {
          "email": emailC.text,
          "no_telp": no_telpC.text,
        };
        //proses upload new image
        if (image != null) {
          File file = File(image!.path);
          //untuk mengambil ext image
          String ext = image!.name.split(".").last;
          await storage.ref('$uid/pic.$ext').putFile(file);
          //untuk menangkap link irl image firestore
          String urlImage = await storage.ref('$uid/pic.$ext').getDownloadURL();
          data.addAll({"pic": urlImage});
        }
        await firestore.collection("peserta").doc(uid).update(data);
        // reset image setelah di hapus
        image = null;
        Get.back();
        Get.snackbar("Berhasil", "Profile Telah di ubah");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile");
      }
    }
  }

  void hapusGambar(String uid) async {
    try {
      await firestore.collection("peserta").doc(uid).update({
        "pic": FieldValue.delete(),
      });
      Get.back();
      Get.snackbar("Berhasil", "Photo profile berhasil di hapus");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat hapus photo profile");
    } finally {
      update();
    }
  }
}
