import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seminar/app/routes/app_pages.dart';
import '../../../controllers/page_index_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          //handle loading/proses
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //mapping data dari firestroe
          //kode if snap.hasData untuk memastikan ke sistem bahwa data tidak null
          if (snap.hasData) {
            Map<String, dynamic> user = snap.data!.data()!;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          user["pic"] != null
                              ? user["pic"]
                              : "https://ui-avatars.com/api/?background=random",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "${user['name']}".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${user['email']}".toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "${user['no_telp']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PROFILE,
                      arguments:
                          user), //menangkap data user untuk dilempar datanya ke halaman update profile
                  leading: Icon(Icons.person),
                  title: Text("Update Profile"),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                  leading: Icon(Icons.key),
                  title: Text("Update Password"),
                ),
                //role
                if (user["role"] == "admin")
                  ListTile(
                    onTap: () => Get.toNamed(Routes.ADD_PESERTA),
                    leading: Icon(Icons.person_add),
                    title: Text("Tambah Akun Peserta"),
                  ),
                ListTile(
                  onTap: () => controller.logout(),
                  leading: Icon(Icons.logout_rounded),
                  title: Text("Logout"),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat data"),
            );
          }
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
