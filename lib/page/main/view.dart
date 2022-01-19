import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/page/home/view.dart';
import 'package:getx_demo/page/mine/view.dart';
import 'package:getx_demo/page/shopping_cart/view.dart';
import 'logic.dart';

class MainPage extends StatelessWidget {
  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.currentIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: '购物车',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '我的',
            ),
          ],
          onTap: (index) {
            logic.updateIndex(index);
          },
        ),
      ),
    );
  }

  Widget get body {
    switch (state.currentIndex.value) {
      case 0:
        return HomePage();
      case 1:
        return ShoppingCartPage();
      case 2:
        return MinePage();
      default:
        return HomePage();
    }
  }
}
