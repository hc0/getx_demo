import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/common/services/user_info_service.dart';
import 'package:getx_demo/page/main/logic.dart';

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
      body: Obx(
        () => Center(
          child: Column(
            children: [
              Text('余额：${UserInfoService.to.balance.value}'),
              Text('购物车：${UserInfoService.to.shoppingCart.length}'),
              Text('订单：${UserInfoService.to.orderList.length}'),
              ElevatedButton(
                child: const Text('订单列表'),
                onPressed: () {
                  AppRouter.share.open(Paths.orderList);
                },
              ),
              ElevatedButton(
                child: const Text('退出'),
                onPressed: () {
                  UserInfoService.to.toLogout();
                  MainLogic.to.updateIndex(0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
