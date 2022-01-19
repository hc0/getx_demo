import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:getx_demo/common/middleware/router_auth.dart';
import 'package:getx_demo/page/goods_detail/view.dart';
import 'package:getx_demo/page/goods_list/view.dart';
import 'package:getx_demo/page/home/view.dart';
import 'package:getx_demo/page/main/view.dart';
import 'package:getx_demo/page/mine/view.dart';
import 'package:getx_demo/page/order_detail/view.dart';
import 'package:getx_demo/page/order_list/view.dart';
import 'package:getx_demo/page/setting/view.dart';
import 'package:getx_demo/page/shopping_cart/view.dart';
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
      name: Paths.main,
      preventDuplicates: true, //防止重复
      page: () => MainPage(), //显示页面
    ),
    GetPage(
      name: Paths.home,
      page: () => HomePage(),
      children: [
        GetPage(
          name: Paths.goodsList,
          page: () => GoodsListPage(),
          children: [
            GetPage(
              name: Paths.goodsDetail,
              page: () => GoodsDetailPage(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: Paths.shoppingCart,
      page: () => ShoppingCartPage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: Paths.mine,
      page: () => MinePage(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      children: [
        GetPage(
          name: Paths.orderList,
          page: () => OrderListPage(),
          children: [
            GetPage(
              name: Paths.orderDetail,
              page: () => OrderDetailPage(),
            ),
          ],
        ),
        GetPage(
          name: Paths.setting,
          page: () => SettingPage(),
        ),
      ],
    ),
  ];
}
