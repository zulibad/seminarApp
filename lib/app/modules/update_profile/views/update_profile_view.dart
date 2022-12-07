import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  //menangkap data user (argument)
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //tampilkan data ke text field
    controller.nikC.text = user["nik"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    controller.no_telpC.text = user["no_telp"];

    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          //tidak boleh diubah
          TextField(
            autocorrect: false,
            readOnly: true,
            controller: controller.nikC,
            decoration: InputDecoration(
              labelText: "NIK",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            readOnly: true,
            controller: controller.nameC,
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.no_telpC,
            decoration: InputDecoration(
              labelText: "Nomor Telepon",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Photo Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!
                              .path), // pilih "File" bertype dart:io bukan html
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["pic"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                user[
                                    "pic"], // pilih image network untuk ambil gambar yg eksis di user
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.hapusGambar(user["uid"]);
                            },
                            child: Text(
                              "Hapus",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text("Belum Memilih Gambar");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Pilih"),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                await controller
                    .updateProfile(user["uid"]); // melempar uid ke controller
              },
              child: Text("SIMPAN"))
        ],
      ),
    );
  }
}
