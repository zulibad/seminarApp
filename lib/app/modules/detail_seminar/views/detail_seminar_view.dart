import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_seminar_controller.dart';

class DetailSeminarView extends GetView<DetailSeminarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailSeminarView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailSeminarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
