import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/entity/goods.dart';
import 'package:getx_demo/common/logger/logger_utils.dart';

import 'state.dart';

class GoodsListLogic extends GetxController {
  final GoodsListState state = GoodsListState();

  void addData() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Container(
          height: 100,
          width: 100,
          child: Text('test'),
        );
      },
    );

    // int id = state.list.length + 1;
    // state.list.add(Goods(title: '新增$id', id: id));
  }

  @override
  void onInit() {
    super.onInit();
    state.list.add(Goods(title: 'asdf', id: 1));
    state.list.add(Goods(title: 'bfer', id: 1));
    state.list.add(Goods(title: '4545', id: 1));
    state.list.add(Goods(title: 'adfg', id: 1));
    state.list.add(Goods(title: 'hdshd', id: 1));
    Logger.write('test GoodsListLogic onInit');
  }

  @override
  void onReady() {
    Logger.write('test GoodsListLogic onReady');
  }

  @override
  void onClose() {
    Logger.write('goods onClose');
  }
}
