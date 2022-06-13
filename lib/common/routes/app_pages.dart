import 'package:get/get.dart';
import 'package:getx_demo/common/middleware/router_auth.dart';
import 'package:getx_demo/page/anchor_scroller/page/custom_anchor_page.dart';
import 'package:getx_demo/page/anchor_scroller/page/link_anchor_page.dart';
import 'package:getx_demo/page/anchor_scroller/view.dart';
import 'package:getx_demo/page/anchor_scroller/page/sliver_page.dart';
import 'package:getx_demo/page/anchor_scroller/page/anchor_page.dart';
import 'package:getx_demo/page/custom_view/view.dart';
import 'package:getx_demo/page/filter/filter_page.dart';
import 'package:getx_demo/page/goods_detail/view.dart';
import 'package:getx_demo/page/goods_list/view.dart';
import 'package:getx_demo/page/home/view.dart';
import 'package:getx_demo/page/link_scrollview/link_scrollview_page.dart';
import 'package:getx_demo/page/login/view.dart';
import 'package:getx_demo/page/main/view.dart';
import 'package:getx_demo/page/mine/view.dart';
import 'package:getx_demo/page/order_detail/view.dart';
import 'package:getx_demo/page/order_list/view.dart';
import 'package:getx_demo/page/router/page_number.dart';
import 'package:getx_demo/page/scroll_view/view.dart';
import 'package:getx_demo/page/setting/view.dart';
import 'package:getx_demo/page/shopping_cart/view.dart';
import 'package:getx_demo/page/state/view.dart';
import 'package:getx_demo/page/welcome/view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.main;

  static final routes = [
    GetPage(
      name: Paths.welcome,
      preventDuplicates: true, //防止重复
      page: () => WelcomePage(),
    ),
    GetPage(
      name: Paths.login,
      preventDuplicates: true, //防止重复
      page: () => LoginPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.main,
      preventDuplicates: true, //防止重复
      page: () => MainPage(), //显示页面
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.home,
      page: () => HomePage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.goodsList,
      page: () => GoodsListPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.goodsDetail,
      page: () => GoodsDetailPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.shoppingCart,
      page: () => ShoppingCartPage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.mine,
      page: () => MinePage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.setting,
      page: () => SettingPage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.orderList,
      page: () => OrderListPage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.orderDetail,
      page: () => OrderDetailPage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.filter,
      page: () => const FilterPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.page1,
      page: () => const PageNumber(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.page2,
      page: () => const PageNumber(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.page3,
      page: () => const PageNumber(),
      transition: Transition.cupertino,
    ),
    //状态管理
    GetPage(
      name: Paths.state,
      page: () => StatePage(),
      transition: Transition.cupertino,
    ),
    //状态管理
    GetPage(
      name: Paths.customView,
      page: () => CustomViewPage(),
      transition: Transition.cupertino,
    ),
    //联动列表
    GetPage(
      name: Paths.link,
      page: () => const LinkPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.sliver,
      page: () => const SliverPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.anchor,
      page: () => const TwAnchorPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.customAnchor,
      page: () => const CustomAnchorPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.linkAnchor,
      page: () => const LinkAnchorPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.linkScrollView,
      page: () => const LinkScrollViewPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Paths.scrollView,
      page: () => ScrollViewPage(),
      transition: Transition.cupertino,
    ),
  ];
}
