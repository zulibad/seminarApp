import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_peserta_controller.dart';

class AddPesertaView extends GetView<AddPesertaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAMBAH PESERTA'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.nikC,
            decoration:
                InputDecoration(labelText: "NIK", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: InputDecoration(
                labelText: "Nama", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.no_telpC,
            decoration: InputDecoration(
                labelText: "Nomor Telepon", border: OutlineInputBorder()),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                controller.addPeserta();
              },
              child: Text("SIMPAN"))
        ],
      ),
    );
  }
}
