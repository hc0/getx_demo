import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_demo/page/anchor_scroller/widget/title_bar_view.dart';

///控件位置-开始与结束
class WidgetPosition {
  //对应tab的下标
  int index;
  //开始位置-相对scroll起始位置
  double begin;
  //结束位置-相对scroll起始位置
  double end;
  //距离底部距离-相对scroll的底部
  double toEndOffset;

  WidgetPosition({
    required this.index,
    required this.begin,
    required this.end,
    required this.toEndOffset,
  });
}

///自定义-锚点
class CustomAnchorPage extends StatefulWidget {
  const CustomAnchorPage({Key? key}) : super(key: key);

  @override
  State<CustomAnchorPage> createState() => _CustomAnchorPageState();
}

class _CustomAnchorPageState extends State<CustomAnchorPage>
    with TickerProviderStateMixin {
  ///状态栏高度
  double get statusBarHeight => ScreenUtil().statusBarHeight;

  ///标题高度
  double get titleHeight => 56.w;

  ///tab高度
  double get tabHeight => 48.w;

  ///header高度
  double get headerHeight => titleHeight + tabHeight + statusBarHeight;

  ///tab数据
  List<String> get tabs => List.generate(itemCount, (index) => ' $index ');

  ///动画控制器
  late AnimationController animationController;

  ///子视图个数
  int itemCount = 15;

  ///tab控制器
  late TabController tabController;

  ///子视图起始位置
  List<WidgetPosition> widgetPositions = [];

  ///滚动视图key
  GlobalKey scrollGlobalKey = GlobalKey();

  ///子视图key
  late List<GlobalKey> globalKeys;

  ///滚动控制器
  late ScrollController scrollController;

  ///对应tab的下标
  WidgetPosition? currentToTabIndex;

  ///定位时向下偏移量
  double get toOffset => headerHeight;

  ///滚动锁-防止多次滚动计算
  bool scrollLock = false;

  @override
  void initState() {
    super.initState();

    //初始化-动画控制器
    animationController = AnimationController(vsync: this);

    globalKeys = List.generate(itemCount, (index) => GlobalKey());

    //初始化-tab控制器与监听
    tabController = TabController(length: itemCount, vsync: this)
      ..addListener(() {
        //点击tab-调整对应位置
        if (tabController.indexIsChanging) {
          jumpTo(tabController.index);
        }
      });

    //初始化-滚动视图控制器与监听
    scrollController = ScrollController()
      ..addListener(() {
        //记录上次位置
        WidgetPosition? tempTabIndex = currentToTabIndex;
        //计算对应tab的下标位置
        getCurrentToTabIndex(scrollController.position.pixels);
        //判断与上次是否同一个视图位置
        if (tempTabIndex != currentToTabIndex) {
          tabController.index = currentToTabIndex!.index;
        }
        //滚动是动画联动
        double temp = scrollController.position.pixels.clamp(0, headerHeight) /
            headerHeight;
        animationController.value = temp;
      });
    //下一贞的回调事件
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      //获取子控件位置
      getPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: scrollView(),
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
  Widget scrollView() {
    return SingleChildScrollView(
      key: scrollGlobalKey,
      controller: scrollController,
      child: Column(
        children: [
          ...List.generate(itemCount, (index) {
            return Container(
              key: globalKeys[index],
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
          })
        ],
      ),
    );
  }

  ///获取-子视图位置
  void getPosition() {
    //滚动视图
    RenderBox scrollRenderBox =
        scrollGlobalKey.currentContext!.findRenderObject() as RenderBox;
    //滚动视图-大小
    // Size scrollSize = scrollRenderBox.size;
    //滚动视图-相对于原点 控件的位置
    Offset scrollOffset = scrollRenderBox.localToGlobal(Offset.zero);

    widgetPositions.clear();

    int globalKeyLength=globalKeys.length;

    for(int index=globalKeyLength-1;index>0;index--){
      RenderBox widgetRenderBox =
      globalKeys[index].currentContext?.findRenderObject() as RenderBox;
      //控件大小
      Size widgetSize = widgetRenderBox.size;
      //相对于原点 控件的位置
      Offset widgetOffset = widgetRenderBox.localToGlobal(Offset.zero);

      // print('test widgetOffset=$widgetOffset tempOffset=$tempOffset');

      double begin = widgetOffset.dy - scrollOffset.dy;
      double end = begin + widgetSize.height;
      widgetPositions.add(WidgetPosition(
        index: index,
        begin: begin,
        end: end,
        toEndOffset: 1,
      ));
    }

    // for (int index = 0, n = globalKeys.length; index < n; index++) {
    //   RenderBox widgetRenderBox =
    //       globalKeys[index].currentContext?.findRenderObject() as RenderBox;
    //   //控件大小
    //   Size widgetSize = widgetRenderBox.size;
    //   //相对于原点 控件的位置
    //   Offset widgetOffset = widgetRenderBox.localToGlobal(Offset.zero);
    //
    //   // print('test widgetOffset=$widgetOffset tempOffset=$tempOffset');
    //
    //   double begin = widgetOffset.dy - scrollOffset.dy;
    //   double end = begin + widgetSize.height;
    //   widgetPositions.add(WidgetPosition(
    //     index: index,
    //     begin: begin,
    //     end: end,
    //     toEndOffset: 1,
    //   ));
    // }
    // for (var element in widgetPositions) {
    //   print('test [${element.begin},${element.end}]');
    // }
  }

  ///获取-对应tab的下标
  void getCurrentToTabIndex(double pixels) {
    //判断是否还是当前下标位置
    if (currentToTabIndex != null) {
      if (pixels > currentToTabIndex!.begin &&
          pixels < currentToTabIndex!.end) {
        return;
      }
    }
    //判断对应下标
    for (var element in widgetPositions) {
      if (pixels > element.begin && pixels < element.end) {
        currentToTabIndex = element;
        // print('test currentToTabIndex=${currentToTabIndex!.index}');
        break;
      }
    }
  }

  ///跳转对应位置
  void jumpTo(int index) {
    if (scrollLock) return;
    scrollLock = true;
    //防止超出下标
    index = index.clamp(0, itemCount);
    WidgetPosition temp = widgetPositions[index];
    //对应位置的视图y坐标 + 向下的偏移量
    double jumpOffset = temp.begin - toOffset;
    if (jumpOffset < 0) {
      jumpOffset = 0;
    }
    scrollController.jumpTo(jumpOffset);
    scrollLock = false;
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
