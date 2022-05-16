import 'package:flutter/material.dart';

class CustomView extends StatefulWidget {
  const CustomView({Key? key}) : super(key: key);

  @override
  State<CustomView> createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView>
    with TickerProviderStateMixin<CustomView> {
  double loadingWidth = 100;

  double displacement = 0;

  double? currentPage;

  int itemCount = 3;

  late AnimationController controller;
  PageController pageController = PageController();

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    displacement = -loadingWidth;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: SizedBox(
              width: constraints.maxWidth,
              height: 200,
              child: Stack(
                children: [
                  PageView.builder(
                    itemBuilder: (context, index) => Container(
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: Text(
                        '第$index页',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    itemCount: itemCount,
                    controller: pageController,
                  ),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Positioned(
                        right: displacement,
                        top: 0,
                        child: Container(
                          height: 200,
                          width: loadingWidth,
                          alignment: Alignment.center,
                          color: Colors.white.withOpacity(0.2),
                          child: const Text('加载中'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!_shouldStart(notification)) {
      return false;
    }
    if (notification is ScrollStartNotification) {
      print('test start drag=${notification.dragDetails}');
    } else if (notification is ScrollUpdateNotification) {
      print('test update drag=${notification.dragDetails}');
    } else if (notification is OverscrollNotification) {
      print('test over = ${notification.overscroll}');
    } else if (notification is ScrollEndNotification) {
      print('test end drag=${notification.dragDetails}');
    }
    return false;
  }

  /// 是否要开始计算滚动
  bool _shouldStart(ScrollNotification notification) {
    print('test notification=${notification.metrics.extentAfter}');
    if (notification is ScrollStartNotification) {
      currentPage = pageController.page!;
      controller.value = 0.0;
      return false;
    } else if (notification is ScrollEndNotification) {
      currentPage = null;
      controller.value = 0.0;
      return false;
    } else if (notification is UserScrollNotification) {
      return false;
    } else if (notification is ScrollUpdateNotification) {
      bool lastPage = currentPage == (itemCount - 1).toDouble();
      print('test axisDirection=${notification.scrollDelta}');

      return lastPage &&
          notification.metrics.axisDirection == AxisDirection.right;
    }
    return false;
  }
}
