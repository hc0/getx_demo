import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/common/services/user_info_service.dart';

import 'state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  static MainLogic get to => Get.find();

  void updateIndex(int index) {
    if (index >= 1 && !UserInfoService.to.isLogin) {
      AppRouter.share.open(
        Paths.login,
        arguments: {'successCallback': ()=>updateIndex(index)},
      );
      return;
    }
    state.currentIndex.value = index;
  }
}
