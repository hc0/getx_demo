import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_demo/page/anchor_scroller/widget/title_bar_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollablePositionPage extends StatefulWidget {
  const ScrollablePositionPage({Key? key}) : super(key: key);

  @override
  State<ScrollablePositionPage> createState() => _ScrollablePositionPageState();
}

class _ScrollablePositionPageState extends State<ScrollablePositionPage>
    with TickerProviderStateMixin {
  //状态栏高度
  double get statusBarHeight => ScreenUtil().statusBarHeight;

  //标题高度
  double get titleHeight => 56.w;

  //tab高度
  double get tabHeight => 48.w;

  //header高度
  double get headerHeight => titleHeight + tabHeight + statusBarHeight;

  // 子项数量
  int get itemCount => 17;

  // tab 数据
  List<String> get tabs => List.generate(itemCount, (index) => '$index');

  //tab控制器
  late TabController tabController;

  //动画控制器
  late AnimationController animationController;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        int index = tabController.index;
        itemScrollController.jumpTo(index: index);
      }
    });
    itemPositionsListener.itemPositions.addListener(() {
      ItemPosition itemPosition = itemPositionsListener.itemPositions.value
          .firstWhere((element) => element.itemLeadingEdge > 0);
      tabController.index = itemPosition.index;

      // for (var element in itemPositionsListener.itemPositions.value) {
      //   print(
      //       'test value=${element.index} itemLeadingEdge=${element.itemLeadingEdge} itemTrailingEdge=${element.itemTrailingEdge}');
      //
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: scrollBySliverView(),
          ),
          TitleBarView(
            animationController: animationController,
            tabController: tabController,
            tabs: tabs,
            statusBarHeight: statusBarHeight,
            titleHeight: titleHeight,
            tabHeight: tabHeight,
          ),
        ],
      ),
    );
  }

  ///滚动视图
  Widget scrollBySliverView() {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          double temp =
              notification.metrics.pixels.clamp(0, headerHeight) / headerHeight;
          animationController.value = temp;
        }
        return false;
      },
      child: ScrollablePositionedList.builder(
        itemCount: itemCount,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            color: Colors.primaries[index],
            child: Column(
              children: [
                Text('Tilte $index'),
                Expanded(
                  child: Container(
                    color: Colors.primaries[itemCount - index],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    tabController.dispose();
    super.dispose();
  }
}
