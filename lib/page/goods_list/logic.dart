import 'package:get/get.dart';
import 'package:getx_demo/shared/logger/logger_utils.dart';

import 'state.dart';

class GoodsListLogic extends GetxController {
  final GoodsListState state = GoodsListState();

  void addData() {
    state.list.add('${state.list.length + 1}');
  }

  @override
  void onReady() {
    Logger.write('goods onReady');
  }

  @override
  void onClose() {
    Logger.write('goods onClose');
  }
}
