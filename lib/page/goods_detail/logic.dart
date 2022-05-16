import 'package:get/get.dart';
import 'package:getx_demo/common/logger/logger_utils.dart';

import 'state.dart';

class GoodsDetailLogic extends GetxController {
  final GoodsDetailState state = GoodsDetailState();

  @override
  void onInit() {
    Logger.write('test onInit');
    state.bean = Get.arguments?['bean'];
    super.onInit();
  }

  @override
  void onReady() {
    Logger.write('test onReady');
    super.onReady();
  }

  void updateNumber() {
    state.number += 1;
  }
}
