import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
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
                AppRouter.share.open(Paths.goodsList, arguments: {'id': 1});
              },
            ),
            ElevatedButton(
              child: const Text('筛选'),
              onPressed: () {
                AppRouter.share.open(Paths.filter);
              },
            ),
            ElevatedButton(
              child: const Text('数字页面'),
              onPressed: () {
                AppRouter.share.open(
                  Paths.page1,
                  arguments: {'number': '1'},
                );
              },
            ),
            ElevatedButton(
              child: const Text('状态管理'),
              onPressed: () {
                AppRouter.share.open(
                  Paths.state,
                  arguments: {'id': 1},
                );
              },
            ),
            ElevatedButton(
              child: const Text('自定义视图'),
              onPressed: () {
                AppRouter.share.open(Paths.customView);
              },
            ),
            ElevatedButton(
              child: const Text('联动列表'),
              onPressed: () {
                AppRouter.share.open(Paths.link);
              },
            ),
            ElevatedButton(
              child: const Text('滚动联动'),
              onPressed: () {
                AppRouter.share.open(Paths.linkScrollView);
              },
            ),
            ElevatedButton(
              child: const Text('滚动学习'),
              onPressed: () {
                AppRouter.share.open(Paths.scrollView);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.share.resetPageRoute();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
