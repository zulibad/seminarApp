import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:seminar/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller
            .streamUser(), // untuk menangkap uid yg di bungkus di controler
        builder: (context, snapshot) {
          //proses loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            String defaultImage =
                "https://ui-avatars.com/api/?background=random";

            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 75,
                        height: 75,
                        color: Colors.grey[300],
                        child: Image.network(
                          user["pic"] != null ? user["pic"] : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SELAMAT DATANG",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "${user['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Undangan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "5",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Menghadiri",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "4",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Riwayat Kehadiran",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TANGGAL",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${DateFormat.jms().format(DateTime.now())}",
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            "${DateFormat.yMMMEd().format(DateTime.now())}",
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat database user"),
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
// kode untuk tampilkan icon berdasarkan role
//memulai memeriksa role user admin atau peserta
//merubah tipe snapshot menjadi document (bukan objek)
// StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//   stream: controller.streamRole(),
//   builder: (context, snap) {
//     if (snap.connectionState == ConnectionState.waiting) {
//       return SizedBox();
//     }
//     String role = snap.data!.data()!["role"];
//     if (role == "admin") {
//       return IconButton(
//         onPressed: () => Get.toNamed(Routes.ADD_PESERTA),
//         icon: Icon(Icons.person_add),
//       );
//     } else {
//       return SizedBox();
//     }
//   },
// ),
