import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/common/widget/action_view.dart';
import 'logic.dart';

class GoodsListPage extends StatelessWidget {
  final logic = Get.put(GoodsListLogic());

  GoodsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('商品列表'),
        actions: const [ActionView()],
      ),
      body: bodyView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 24),
        onPressed: logic.addData,
      ),
    );
  }

  Widget bodyView() {
    return Obx(
      () => ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(logic.state.list[index].title ?? ''),
          subtitle: Text('${logic.state.list[index].id}'),
          onTap: () {
            AppRouter.share.open(
              Paths.goodsDetail,
              arguments: {'bean': logic.state.list[index]},
            );
            // Navigator.of(context).push<void>(
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => LoginPage(),
            //   ),
            // );
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: logic.state.list.length,
      ),
    );
  }
}
