import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class OrderDetailPage extends StatelessWidget {
  final logic = Get.put(OrderDetailLogic());
  final state = Get.find<OrderDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订单详情'),
      ),
    );
  }
}
