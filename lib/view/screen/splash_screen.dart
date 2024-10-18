import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_exam/view/screen/signup.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () => Get.to(SignupScreen()),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 320, left: 30),
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png'))),
            ),
          )
        ],
      ),
    );
  }
}
