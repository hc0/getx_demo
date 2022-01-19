import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class OrderListPage extends StatelessWidget {
  final logic = Get.put(OrderListLogic());
  final state = Get.find<OrderListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订单列表'),
      ),
    );
  }
}
