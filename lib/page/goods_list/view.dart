import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/widget/action_view.dart';

import 'logic.dart';

class GoodsListPage extends StatelessWidget {
  final logic = Get.put(GoodsListLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品列表'),
        actions: const [ActionView()],
      ),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(logic.state.list[index].title ?? ''),
            subtitle: Text('${logic.state.list[index].id}'),
            onTap: () {
              Get.toNamed(
                Paths.goodsDetail,
                arguments: {'bean': logic.state.list[index]},
              );
            },
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: logic.state.list.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 24),
        onPressed: logic.addData,
      ),
    );
  }
}
