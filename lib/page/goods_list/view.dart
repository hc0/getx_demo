import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/page/main/logic.dart';

import 'logic.dart';

class GoodsListPage extends StatelessWidget {
  final logic = Get.put(GoodsListLogic());
  final state = Get.find<GoodsListLogic>().state;
  final mainState = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品列表'),
      ),
    );
  }

}
