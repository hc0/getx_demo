import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/services/user_info_service.dart';

class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware();

  @override
  RouteSettings? redirect(String? route) {
    if (UserInfoService.to.isLogin) {
      return null;
      // return RouteSettings(name: route);
    }
    return const RouteSettings(name: AppRoutes.login);
  }
}
