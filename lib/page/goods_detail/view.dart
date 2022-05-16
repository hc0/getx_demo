import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/services/user_info_service.dart';
import 'package:getx_demo/common/widget/action_view.dart';
import 'logic.dart';

class GoodsDetailPage extends StatelessWidget {
  final logic = Get.put(GoodsDetailLogic());
  final state = Get.find<GoodsDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品详情'),
        actions: const [ActionView()],
      ),
      body: Center(
        child: Column(
          children: [
            Text('${state.bean?.id}').marginAll(10),
            Text(state.bean?.title ?? '').marginAll(10),
            ElevatedButton(
              onPressed: () {
                UserInfoService.to.checkLoginAndCallback(() {
                  UserInfoService.to.addOrderList(state.bean!);
                  Get.toNamed(
                    Paths.orderDetail,
                    arguments: {'bean': state.bean!},
                  );
                  Get.snackbar(
                    "提示",
                    "购买成功",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                });
              },
              child: const Text('购买'),
            ).marginAll(10),
            ElevatedButton(
              onPressed: () {
                UserInfoService.to.checkLoginAndCallback(() {
                  UserInfoService.to.addShoppingCart(state.bean!);
                  Get.snackbar(
                    "提示",
                    "加入成功",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                });
              },
              child: const Text('加入购物车'),
            ).marginAll(10),
          ],
        ),
      ),
    );
  }
}
