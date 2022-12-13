import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/add_seminar_controller.dart';

class AddSeminarView extends GetView<AddSeminarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Jadwal Seminar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.idsC,
            decoration: InputDecoration(
                labelText: "ID Seminar", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.temaC,
            decoration: InputDecoration(
                labelText: "Tema Seminar", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.pembicaraC,
            decoration: InputDecoration(
                labelText: "Pembicara", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.lokasiC,
            decoration: InputDecoration(
                labelText: "Lokasi", border: OutlineInputBorder()),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autocorrect: false,
              controller: controller.tanggalC,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today_rounded),
                labelText: "Tanggal",
              ),
              onTap: () async {
                DateTime? pilihTanggal = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2023),
                );
                if (pilihTanggal != null) {
                  controller.tanggalC.text =
                      DateFormat('dd-MM-yyyy').format(pilihTanggal).toString();
                }
              },
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autocorrect: false,
              controller: controller.waktuC,
              decoration: const InputDecoration(
                icon: Icon(Icons.access_time_rounded),
                labelText: "Waktu",
              ),
              onTap: () async {
                TimeOfDay? pilihWaktu = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pilihWaktu != null) {
                  controller.waktuC.text = pilihWaktu.format(context);
                }
              },
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                controller.addSeminar();
              },
              child: Text("SIMPAN"))
        ],
      ),
    );
  }
}
