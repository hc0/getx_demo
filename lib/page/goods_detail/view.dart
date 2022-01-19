import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class GoodsDetailPage extends StatelessWidget {
  final logic = Get.put(GoodsDetailLogic());
  final state = Get.find<GoodsDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品详情'),
      ),
    );
  }
}
