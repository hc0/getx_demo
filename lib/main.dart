import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_demo/routes/app_pages.dart';
import 'package:getx_demo/shared/logger/logger_utils.dart';

late Directory appDocsDir;

void main() async {

  runApp(GetMaterialApp.router(
    debugShowCheckedModeBanner: false,
    enableLog: true,
    logWriterCallback: Logger.write,
    // initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ));
}
