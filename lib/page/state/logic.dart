import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'state.dart';

class StateLogic extends GetxController {
  final StateState state = StateState();

  @override
  void onInit() {
    debugPrint('test StateLogic 开始');
    super.onInit();
    state.pageNumber = Get.arguments['id'];
    state.currentNumber.value = Get.arguments['currentNumber'] ?? 1;
    state.subNumber.value = Get.arguments['subNumber'] ?? 99;
    debugPrint('test StateLogic 结束');
  }
}
