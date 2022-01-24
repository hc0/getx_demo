import 'package:get/get.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    super.onInit();
    state.successCallback = Get.arguments['successCallback'];
  }
}
