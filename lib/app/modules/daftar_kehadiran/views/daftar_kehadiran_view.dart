import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/daftar_kehadiran_controller.dart';

class DaftarKehadiranView extends GetView<DaftarKehadiranController> {
  // final seminar = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // print(seminar['id_s']);
    return Scaffold(
      appBar: AppBar(
        title: Text('DaftarKehadiranView'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.streamSeminar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            var hadir = snapshot.data!.docs;

            return ListView.builder(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: hadir.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${(hadir[index].data() as Map<String, dynamic>)["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(hadir[index].data() as Map<String, dynamic>)["date"]}",
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${(hadir[index].data() as Map<String, dynamic>)["email"]}",
                            ),
                            Text(
                              "${(hadir[index].data() as Map<String, dynamic>)["time"]}",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("tidak dapat mengambil database"),
            );
          }
        },
      ),
    );
  }
}
