import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/daftar_peserta_controller.dart';

class DaftarPesertaView extends GetView<DaftarPesertaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Peserta'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.User(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var user = snapshot.data!.docs;
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${(user[index].data() as Map<String, dynamic>)["pic"]}"),
                ),
                title: Text(
                    "${(user[index].data() as Map<String, dynamic>)["name"]}"),
                subtitle: Text(
                    "${(user[index].data() as Map<String, dynamic>)["email"]}"),
              ),
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat data"),
            );
          }
        },
      ),
    );
  }
}
