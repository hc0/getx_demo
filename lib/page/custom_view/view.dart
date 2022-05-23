import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/page/custom_view/custom_page_view.dart';
import 'logic.dart';

class CustomViewPage extends StatelessWidget {
  final logic = Get.put(CustomViewLogic());
  final state = Get.find<CustomViewLogic>().state;

  CustomViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义视图'),
        centerTitle: true,
      ),
      body: CustomPageView(
        itemCount: 4,
        builder: (context, model) {
          return Container(
            alignment: Alignment.center,
            color: Colors.primaries[Random().nextInt(18).ceil()],
            child: Text('第$model页'),
          );
        },
        completed: () {
          AppRouter.share.open(Paths.goodsList);
        },
      ),
    );
  }
}
