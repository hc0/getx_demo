import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/logger/logger_utils.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/services/global_service.dart';
import 'package:getx_demo/common/services/user_info_service.dart';

///运行app
void main() async {
  await initServices();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    enableLog: true,
    logWriterCallback: Logger.write,
    initialRoute: AppPages.initial,
    getPages: AppPages.routes,
  ));
}

/// 初始化服务
Future initServices() async {
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => UserInfoService().init());
}
