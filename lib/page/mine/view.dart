import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MinePage extends StatelessWidget {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会员中心'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('会员中心'),
      ),
    );
  }
}
