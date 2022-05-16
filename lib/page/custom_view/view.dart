import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/page/custom_view/custom_view.dart';
import 'package:getx_demo/page/custom_view/my_list_refresh.dart';
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
      body: listViewAndRefreshView(),
      // body: const CustomPageView(),
      // body: const CustomView(),
    );
  }

  /// 列表刷新
  Widget listViewAndRefreshView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MyListRefresh(
          child: ListView.builder(
            physics: PageScrollPhysics(),
            itemBuilder: (context, index) => Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              alignment: Alignment.center,
              color: Colors.primaries[index],
              child: Text('第$index个'),
            ),
            itemCount: 3,
          ),
          onRefresh: onRefresh,
        );
      },
    );
  }

  Future onRefresh() async {
    await Future.delayed(const Duration(seconds: 3), () {});
  }
}
