import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'logic.dart';

class StateBinding extends Bindings {
  @override
  void dependencies() {
    String tag = Get.arguments['id'].toString();
    debugPrint('test tag=$tag');
    // Get.lazyPut(() => StateLogic(), tag: tag);
    Get.lazyPut(() => StateLogic());
  }
}
