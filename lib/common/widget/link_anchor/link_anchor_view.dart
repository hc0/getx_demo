import 'package:flutter/material.dart';
import 'package:getx_demo/common/widget/link_anchor/link_anchor_controller.dart';

typedef LinkAnchorBuild = Widget Function(BuildContext context, int index);

///联动+锚点-控件
class LinkAnchorView extends StatefulWidget {
  final int itemCount;
  final LinkAnchorBuild build;
  final LinkAnchorController? controller;

  const LinkAnchorView({
    Key? key,
    required this.itemCount,
    required this.build,
    this.controller,
  }) : super(key: key);

  @override
  State<LinkAnchorView> createState() => _LinkAnchorViewState();
}

class _LinkAnchorViewState extends State<LinkAnchorView> {
  late LinkAnchorController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? LinkAnchorController();
    controller.itemCount = widget.itemCount;
    controller.globalKeys =
        List.generate(controller.itemCount, (index) => GlobalKey());

    controller.scrollController = ScrollController()
      ..addListener(controller.scrollListener);

    //下一贞的回调事件
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //获取子控件位置
      controller.getPosition();
      //设置初始值
      controller.setInitIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: SingleChildScrollView(
            key: controller.scrollGlobalKey,
            controller: controller.scrollController,
            child: Column(
              children: [
                ...List.generate(
                  widget.itemCount,
                  (index) {
                    Widget child = widget.build(context, index);
                    if (child.key is GlobalKey &&
                        child.key != controller.globalKeys[index]) {
                      controller.globalKeys[index] = child.key as GlobalKey;
                    } else {
                      child = SizedBox(
                        key: controller.globalKeys[index],
                        child: child,
                      );
                    }
                    return child;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant LinkAnchorView oldWidget) {
    super.didUpdateWidget(oldWidget);


    controller.scrollController.removeListener(controller.scrollListener);
    controller.globalKeys =
        List.generate(widget.itemCount, (index) => GlobalKey());
    setState(() {});
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.getPosition();
      controller.scrollController.addListener(controller.scrollListener);
    });
  }

  @override
  void dispose() {
    controller.scrollController.dispose();
    super.dispose();
  }
}
