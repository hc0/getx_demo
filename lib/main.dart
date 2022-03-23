import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/routes/app_pages.dart';
import 'package:getx_demo/shared/logger/logger_utils.dart';

late Directory appDocsDir;

void main() async {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    enableLog: true,
    logWriterCallback: Logger.write,
    initialRoute: AppPages.initial,
    getPages: AppPages.routes,
    routingCallback: (Routing? routing) {
      Logger.write('test routingCallback =${routing?.current}');
    },
    builder: (BuildContext context, Widget? child) {
      Logger.write('test builder =${Get.currentRoute}');
      return child!;
    },
  ));
}
