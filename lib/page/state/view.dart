import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/page/state/state.dart';
import 'package:getx_demo/page/state/widget/state_sub_view.dart';

import 'logic.dart';

class StatePage extends StatelessWidget {
  final StateLogic logic =
      Get.put(StateLogic(), tag: Get.arguments['id'].toString());
  late final StateState state = logic.state;

  StatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是第${state.pageNumber}个页面'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            currentView(),
            const SizedBox(height: 20),
            StateSubView(),
          ],
        ),
      ),
    );
  }

  ///当前页面视图
  Widget currentView() {
    int tempIndex = state.pageNumber;
    if (tempIndex >= Colors.primaries.length) {
      tempIndex = 0;
    }
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.primaries[state.pageNumber].withOpacity(0.3),
      child: Column(
        children: [
          Obx(() {
            return Text('${state.currentNumber}');
          }).marginAll(10),
          ElevatedButton(
            onPressed: () {
              state.currentNumber++;
            },
            child: const Text('+1'),
          ).marginAll(10),
          ElevatedButton(
            onPressed: () {
              AppRouter.share.open(Paths.state, arguments: {
                'id': state.pageNumber + 1,
                'currentNumber': state.currentNumber.value,
              });
            },
            child: const Text('下一个页面'),
          ).marginAll(10),
        ],
      ),
    );
  }
}
