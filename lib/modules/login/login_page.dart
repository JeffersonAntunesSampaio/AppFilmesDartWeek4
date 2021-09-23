import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {

  final LoginController controller = Get.find();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/images/background.png",
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black45,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  height: 42,
                  child: SignInButton(
                    Buttons.Google,
                    text: "Entrar com o Google",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () {
                      controller.login();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
