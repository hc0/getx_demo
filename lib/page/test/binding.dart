import 'package:get/get.dart';

import 'logic.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestLogic());
  }
}
