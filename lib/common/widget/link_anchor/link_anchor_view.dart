import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getx_demo/common/services/global_service.dart';
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
    controller.reBuildView = reBuildView;

    controller.itemCount = widget.itemCount;

    controller.scrollController = ScrollController()
      ..addListener(controller.scrollListener);

    //下一贞的回调事件
    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
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

  void reBuildView() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.scrollController.dispose();
    super.dispose();
  }
}
