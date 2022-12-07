import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seminar/app/controllers/page_index_controller.dart';
import 'package:seminar/app/routes/app_pages.dart';

import '../controllers/seminar_controller.dart';

class SeminarView extends GetView<SeminarController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Seminar'),
        centerTitle: true,
        actions: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamRole(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              String role = snap.data!.data()!["role"];
              if (role == "admin") {
                return IconButton(
                  onPressed: () => Get.toNamed(Routes.ADD_SEMINAR),
                  icon: Icon(Icons.insert_invitation_rounded),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.getSeminar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var seminar = snapshot.data!.docs;
            return ListView.builder(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: seminar.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.toNamed(Routes.DETAIL_SEMINAR),
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
                              "TEMA SEMINAR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(seminar[index].data() as Map<String, dynamic>)["date"]}",
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
                              "${(seminar[index].data() as Map<String, dynamic>)["tema"]}",
                            ),
                            Text(
                              "${(seminar[index].data() as Map<String, dynamic>)["time"]}",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.insert_invitation, title: 'Seminar'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.pindahHalaman(i),
      ),
    );
  }
}
