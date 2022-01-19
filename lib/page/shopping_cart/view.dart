import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ShoppingCartPage extends StatelessWidget {
  final logic = Get.put(ShoppingCartLogic());
  final state = Get.find<ShoppingCartLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('购物车'),
      ),
    );
  }
}
