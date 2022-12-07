import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.passLamaC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password Lama",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.passBaruC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password Baru",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.conPassBaruC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Konfirmasi Password Baru",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.updatePass(),
            child: Text("SIMPAN"),
          ),
        ],
      ),
    );
  }
}
