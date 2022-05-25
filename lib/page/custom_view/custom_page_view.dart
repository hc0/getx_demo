import 'package:flutter/material.dart';
import 'package:getx_demo/page/custom_view/page_view_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef PageWidgetBuilder<T> = Widget Function(BuildContext context, int index);

///自定PageView
class CustomPageView extends StatefulWidget {
  final int itemCount;
  final PageWidgetBuilder builder;
  final VoidCallback? completed;

  const CustomPageView({
    Key? key,
    required this.itemCount,
    required this.builder,
    this.completed,
  }) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView>
    with SingleTickerProviderStateMixin {
  RefreshController controller = RefreshController();
  ScrollController scrollController = ScrollController();
  late BoxConstraints constraints;
  late int itemCount;

  @override
  void initState() {
    itemCount = widget.itemCount;
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(constraints.maxWidth * (itemCount - 1));
    });
  }

  @override
  void didUpdateWidget(covariant CustomPageView oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      itemCount = widget.itemCount;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        this.constraints = constraints;
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: controller,
          reverse: true,
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          onRefresh: _onCompleted,
          header: const PageViewFooter(),
          child: ListView.builder(
            controller: scrollController,
            itemCount: itemCount,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                widget.builder(context, itemCount - 1 - index),
            itemExtent: constraints.maxWidth,
          ),
        );
      },
    );
  }

  ///完成滚动-
  void _onCompleted() {
    controller.refreshCompleted();
    widget.completed?.call();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
