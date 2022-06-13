import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(ShoppingCartLogic());

  final state = Get.find<ShoppingCartLogic>().state;

  late AnimationController controller;

  late ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return NotificationListener(
            onNotification: (notification) {
              print('test type=${notification.runtimeType}');
              if (notification is OverscrollNotification) {
                print('test overScroll=${notification.overscroll}');
              } else if (notification is ScrollEndNotification) {
                print('test max=${notification.metrics.maxScrollExtent}');
                scrollController.animateTo(2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
              }
              return false;
            },
            child: SizedBox(
              width: constraints.maxWidth,
              height: 200,
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(right: 200),
                    physics: const PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      3,
                      (index) => Container(
                        width: constraints.maxWidth,
                        height: 200,
                        color: Colors.primaries[index],
                        alignment: Alignment.center,
                        child: Text('$index'),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
