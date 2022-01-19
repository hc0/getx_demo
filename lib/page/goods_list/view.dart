import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/page/main/logic.dart';

import 'logic.dart';

class GoodsListPage extends StatelessWidget {
  final logic = GoodsListLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品列表'),
      ),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(logic.state.list[index]),
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
