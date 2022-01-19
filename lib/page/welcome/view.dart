import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.put(WelcomeLogic());
  final state = Get.find<WelcomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎'),
      ),
    );
  }
}
