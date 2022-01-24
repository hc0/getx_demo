import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/page/main/logic.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('购物车'),
              onPressed: () {
                MainLogic.to.updateIndex(1);
              },
            ),
            ElevatedButton(
              child: const Text('我的'),
              onPressed: () {
                MainLogic.to.updateIndex(2);
              },
            ),
            ElevatedButton(
              child: const Text('商品列表'),
              onPressed: () {
                Get.toNamed(Paths.goodsList);
              },
            ),
          ],
        ),
      ),
    );
  }
}
