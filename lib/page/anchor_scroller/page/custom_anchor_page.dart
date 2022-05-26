import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_demo/common/widget/link_anchor/widget_position_model.dart';
import 'package:getx_demo/page/anchor_scroller/widget/my_page_view.dart';
import 'package:getx_demo/page/anchor_scroller/widget/title_bar_view.dart';

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
  List<String> get tabs =>
      List.generate(itemCount, (index) => ' ${index + 1} ');

  ///动画控制器
  late AnimationController animationController;

  ///子视图个数
  int itemCount = 14;

  ///tab控制器
  late TabController tabController;

  ///子视图起始位置
  List<WidgetPosition> widgetPositions = [];

  ///滚动视图key
  GlobalKey scrollGlobalKey = GlobalKey();

  ///滚动控件大小
  late Size scrollSize;

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
        if (!scrollLock) {
          //记录上次位置
          WidgetPosition? tempTabIndex = currentToTabIndex;
          //计算对应tab的下标位置
          getCurrentToTabIndex(scrollController.position.pixels);
          //判断与上次是否同一个视图位置
          if (tempTabIndex != currentToTabIndex) {
            tabController.index = currentToTabIndex!.index;
          }
        }

        //滚动是动画联动
        double displayHeight =
            (widgetPositions.first.size.height - headerHeight).abs();
        double temp = scrollController.position.pixels.clamp(0, displayHeight) /
            displayHeight;
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
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
        },
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
            if (index == 5) {
              return MyPageView(
                tabs: tabs,
                key: globalKeys[index],
              );
            } else {
              return Container(
                key: globalKeys[index],
                height: 200,
                color: Colors.primaries[index],
                child: Column(
                  children: [
                    Text('Tilte ${index + 1}'),
                    Expanded(
                      child: Container(
                        color: Colors.primaries[itemCount - index],
                      ),
                    )
                  ],
                ),
              );
            }
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
    scrollSize = scrollRenderBox.size;
    //滚动视图-相对于原点 控件的位置
    Offset scrollOffset = scrollRenderBox.localToGlobal(Offset.zero);

    widgetPositions.clear();

    int globalKeyLength = globalKeys.length;

    //倒序遍历-为了计算控件距离scroll底部距离
    double tempHeight = 0;
    for (int index = globalKeyLength - 1; index >= 0; index--) {
      RenderBox widgetRenderBox =
          globalKeys[index].currentContext?.findRenderObject() as RenderBox;
      //子控件大小
      Size widgetSize = widgetRenderBox.size;
      //相对于原点-子控件的位置
      Offset widgetOffset = widgetRenderBox.localToGlobal(Offset.zero);
      //子控件-开始与结束坐标
      double begin = widgetOffset.dy - scrollOffset.dy;
      double end = begin + widgetSize.height;

      widgetPositions.insert(
        0,
        WidgetPosition(
          index: index,
          begin: begin,
          end: end,
          size: widgetSize,
          endToScrollEndHeight: tempHeight,
        ),
      );
      tempHeight += widgetSize.height;
    }
  }

  ///获取-对应tab的下标
  void getCurrentToTabIndex(double pixels) {
    //兼容顶部偏移量
    pixels += toOffset;
    //判断是否还是当前下标位置
    if (currentToTabIndex != null) {
      if (pixels > currentToTabIndex!.begin &&
          pixels < currentToTabIndex!.end) {
        return;
      }
    }
    //判断对应下标
    for (var element in widgetPositions) {
      if (pixels >= element.begin && pixels <= element.end) {
        currentToTabIndex = element;
        break;
      }
    }
  }

  ///跳转对应位置
  void jumpTo(int index) {
    //滚动锁
    if (scrollLock) return;
    scrollLock = true;
    //防止超出下标
    index = index.clamp(0, itemCount - 1);
    WidgetPosition temp = widgetPositions[index];
    //对应位置的视图y坐标 + 向下的偏移量
    double jumpOffset = temp.begin;
    if (temp.begin - toOffset <= 0) {
      //跳转至顶部-超出scroll最上方-重置为scroll最顶部
      jumpOffset = 0;
    } else if (temp.endToScrollEndHeight + temp.size.height <
        scrollSize.height - toOffset) {
      //滚动过大-防止回弹
      double toUpOffset =
          scrollSize.height - temp.endToScrollEndHeight - temp.size.height;
      jumpOffset -= toUpOffset;
    } else {
      jumpOffset -= toOffset;
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
