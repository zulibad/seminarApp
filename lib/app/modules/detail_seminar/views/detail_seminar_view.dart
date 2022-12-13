import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seminar/app/routes/app_pages.dart';
import '../controllers/detail_seminar_controller.dart';

class DetailSeminarView extends GetView<DetailSeminarController> {
  final seminar = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Seminar'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.toNamed(
              Routes.DAFTAR_KEHADIRAN,
              arguments: seminar,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
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
                      IconButton(
                        onPressed: () {
                          controller.daftarHadir();
                        },
                        icon: Icon(Icons.qr_code_scanner),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${seminar['tema']}",
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Pembicara : ${seminar['pembicara']}",
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Lokasi : ${seminar['lokasi']}",
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${seminar['date']}",
                    style: TextStyle(),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${seminar['time']}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
