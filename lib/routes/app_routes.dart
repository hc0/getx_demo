part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const main = Paths.main;
  static const welcome = Paths.welcome;
  static const home = Paths.home;
  static const shoppingCart = Paths.shoppingCart;
  static const mine = Paths.mine;

  static const goodsList = Paths.goodsList;
  static const goodsDetail = Paths.goodsDetail;
  static const orderList = Paths.orderList;
  static const orderDetail = Paths.orderDetail;
  static const setting = Paths.setting;
}

abstract class Paths {
  static const welcome = '/welcome';

  static const main = '/main';
  static const home = '/home';
  static const shoppingCart = '/shoppingCart';
  static const mine = '/mine';

  static const goodsList = '/goodsList';
  static const goodsDetail = '/goodsDetail';
  static const orderList = '/orderList';
  static const orderDetail = '/orderDetail';
  static const setting = '/setting';
}
