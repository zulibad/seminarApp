import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_seminar_controller.dart';

class DetailSeminarView extends GetView<DetailSeminarController> {
  var seminar = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(seminar);

    return Scaffold(
      appBar: AppBar(
        title: Text('DetailSeminarView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 170,
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
                    Text(
                      "Status Kehadiran",
                      style: TextStyle(),
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
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.scanQcode();
                },
                child: Text("Scan Absen"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
