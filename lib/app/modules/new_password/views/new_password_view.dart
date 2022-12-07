import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UBAH PASSWORD'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: controller.newPassC,
              decoration: InputDecoration(
                labelText: "Password Baru",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  controller.newPassword();
                },
                child: Text("SIMPAN"))
          ],
        ));
  }
}
