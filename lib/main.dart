import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/logger/logger_utils.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/common/services/global_service.dart';
import 'package:getx_demo/common/services/user_info_service.dart';

///运行app
void main() async {
  await initServices();

  runApp(ScreenUtilInit(
    //屏幕适配
    designSize: const Size(375, 667),
    minTextAdapt: true,
    splitScreenMode: true,
    //toast提示
    builder: () => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      navigatorObservers: [AppRouter.share],
      builder: (context, widget) {
        ScreenUtil.setContext(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    ),
  ));
}

/// 初始化服务
Future initServices() async {
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => UserInfoService().init());
}
