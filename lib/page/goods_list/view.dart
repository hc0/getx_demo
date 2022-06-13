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
      // body: bodyView(),
      body: const PositionAnimatedView(),
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
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: logic.state.list.length,
      ),
    );
  }
}

class PositionAnimatedView extends StatefulWidget {
  const PositionAnimatedView({Key? key}) : super(key: key);

  @override
  State<PositionAnimatedView> createState() => _PositionAnimatedViewState();
}

class _PositionAnimatedViewState extends State<PositionAnimatedView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> translate;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    translate = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                      29,
                      (index) => ListTile(
                        title: Text('$index'),
                        onTap: () {
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                      ),
                    )),
                  ),
                  Positioned(
                    bottom: 0,
                    child: buildAnimatedBuilder(constraints),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              color: Colors.orange,
              child: const Text('bottom view'),
            ),
          ],
        );
      },
    );
  }

  Widget buildAnimatedBuilder(BoxConstraints constraints) {
    return SlideTransition(
      position: translate,
      child: Container(
        width: constraints.maxWidth - 32,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.green,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Text('stack animated' * 5),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
