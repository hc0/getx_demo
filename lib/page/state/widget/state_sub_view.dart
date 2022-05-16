import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/page/state/logic.dart';
import 'package:getx_demo/page/state/state.dart';

///子页面
class StateSubView extends StatelessWidget {
  late final StateLogic logic =
      Get.find<StateLogic>(tag: Get.arguments['id'].toString());
  late final StateState state = logic.state;

  StateSubView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int tempIndex = state.pageNumber + 1;
    if (tempIndex >= Colors.primaries.length) {
      tempIndex = 1;
    }
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.primaries[tempIndex].withOpacity(0.3),
      child: Column(
        children: [
          Obx(() {
            return Text('${state.subNumber}');
          }).marginAll(10),
          ElevatedButton(
            onPressed: () {
              state.subNumber--;
            },
            child: const Text('-1'),
          ).marginAll(10),
          ElevatedButton(
            onPressed: () {
              AppRouter.share.open(Paths.state, arguments: {
                'id': state.pageNumber + 1,
                'subNumber': state.subNumber.value,
              });
            },
            child: const Text('下一个页面'),
          ).marginAll(10),
        ],
      ),
    );
  }
}
