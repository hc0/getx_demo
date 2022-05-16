import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';

import 'logic.dart';

class ShoppingCartPage extends StatelessWidget {
  final logic = Get.put(ShoppingCartLogic());
  final state = Get.find<ShoppingCartLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(state.shoppingCart[index].title ?? ''),
          subtitle: Text('${state.shoppingCart[index].id}'),
          onTap: () {
            AppRouter.share.open(
              Paths.goodsDetail,
              arguments: {'bean': logic.state.shoppingCart[index]},
            );
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: state.shoppingCart.length,
      ),
    );
  }
}
