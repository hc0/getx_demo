import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/services/user_info_service.dart';
import 'package:getx_demo/page/main/logic.dart';

class ActionView extends StatelessWidget {
  const ActionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Get.until((route) => Get.currentRoute == Paths.main);
            MainLogic.to.updateIndex(1);
          },
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Obx(
            () {
              int count = UserInfoService.to.shoppingCart.length;
              if (count == 0) return const SizedBox.shrink();
              return Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
