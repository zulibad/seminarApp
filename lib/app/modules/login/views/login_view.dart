import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:seminar/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        // title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            CircleAvatar(
              radius: 80,
              child: Center(child: Text("LOGO")),
            ),
            SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              obscureText: true,
              controller: controller.passC,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            //karena memantau perubahan maka dibungkus obx
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.login();
                  }
                },
                child:
                    Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
              ),
            ),
            TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: Text("Lupa Password ?"))
          ],
        ),
      ),
    );
  }
}
