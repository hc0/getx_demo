import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/common/services/user_info_service.dart';
import 'package:getx_demo/common/widget/action_view.dart';
import 'logic.dart';

class GoodsDetailPage extends StatelessWidget {
  final logic = Get.put(GoodsDetailLogic());
  final state = Get.find<GoodsDetailLogic>().state;

  GoodsDetailPage({Key? key}) : super(key: key);

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
                  AppRouter.share.open(
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
            Obx(() {
              return Text('${logic.state.number}');
            }).marginAll(10),
            ElevatedButton(
              onPressed: () {
                logic.state.number++;
              },
              child: const Text('购买'),
            ).marginAll(10),
            ElevatedButton(
              onPressed: () {
                AppRouter.share.open(Paths.goodsDetail);
              },
              child: const Text('go'),
            ).marginAll(10),
          ],
        ),
      ),
    );
  }
}

class TwoPage extends MyPage<GoodsDetailLogic> {
  @override
  final GoodsDetailLogic logic = GoodsDetailLogic();

  TwoPage({Key? key}) : super(key: key);

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
            Obx(() {
              return Text('${logic.state.number}');
            }).marginAll(10),
            ElevatedButton(
              onPressed: () {
                logic.state.number++;
              },
              child: const Text('购买'),
            ).marginAll(10),
            Text('${logic.state.bean?.id}').marginAll(10),
            Text(logic.state.bean?.title ?? '').marginAll(10),
            ElevatedButton(
              onPressed: () {
                logic.state.bean?.id = logic.state.number.value;
                logic.update();
              },
              child: const Text('更新'),
            ).marginAll(10),
            ElevatedButton(
              onPressed: () {
                UserInfoService.to.checkLoginAndCallback(() {
                  UserInfoService.to.addOrderList(logic.state.bean!);
                  AppRouter.share.open(
                    Paths.orderDetail,
                    arguments: {'bean': logic.state.bean!},
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
                  UserInfoService.to.addShoppingCart(logic.state.bean!);
                  Get.snackbar(
                    "提示",
                    "加入成功",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                });
              },
              child: const Text('加入购物车'),
            ).marginAll(10),
            ElevatedButton(
              onPressed: () {
                AppRouter.share
                    .open(Paths.goodsDetail, preventDuplicates: false);
              },
              child: const Text('go'),
            ).marginAll(10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 24),
        onPressed: () {
          Get.offNamed(Paths.goodsList);
        },
      ),
    );
  }
}

abstract class MyPage<T extends GetxController> extends StatefulWidget {
  late T? logic;

  MyPage({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    widget.logic?.onInit();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.logic?.onReady();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void dispose() {
    widget.logic?.onClose();
    super.dispose();
  }
}
