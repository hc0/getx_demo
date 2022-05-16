import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_demo/common/entity/goods.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';
import 'package:getx_demo/common/values/storage.dart';

/// 用户信息
class UserInfoService extends GetxService {
  static UserInfoService get to => Get.find();

  // 是否登入
  bool isLogin = false;

  // 余额
  RxInt balance = 1000.obs;

  //购物车
  RxList<Goods> shoppingCart = <Goods>[].obs;

  //订单列表
  RxList<Goods> orderList = <Goods>[].obs;

  Future<UserInfoService> init() async {
    readLogin();
    readUserInfo();
    return this;
  }

  /// 读取-登入状态
  void readLogin() {
    isLogin = GetStorage().read(LOGIN) ?? false;
  }

  /// 存储-登入状态
  void writeLogin({bool isLogin = false}) {
    this.isLogin = isLogin;
    GetStorage().write(LOGIN, isLogin);
  }

  /// 是否能购买
  bool canBuy(int price) => balance.value >= price;

  /// 读取-用户信息
  void readUserInfo() {
    if (!isLogin) return;
    balance.value = GetStorage().read(USER_INFO) ?? 1000;
    readShoppingCart();
    readOrderList();
  }

  /// 存储-用户信息
  void writeUserInfo({int balance = 0}) {
    if (!isLogin) return;
    this.balance.value = balance;
    GetStorage().write(USER_INFO, balance);
  }

  /// 读取-购物车数据
  void readShoppingCart() {
    if (!isLogin) return;
    String? temp = GetStorage().read(SHOPPING_CART);
    if (temp != null) {
      List tempList = json.decode(temp);
      for (var element in tempList) {
        shoppingCart.add(Goods(
          id: element['id'],
          title: element['title'],
          price: element['price'],
        ));
      }
    }
  }

  /// 存储-购物车数据
  void writeShoppingCart() {
    if (!isLogin) return;
    GetStorage().write(SHOPPING_CART, json.encode(shoppingCart));
  }

  /// 增加-购物车数据
  bool addShoppingCart(Goods bean) {
    if (!isLogin) return false;
    shoppingCart.add(bean);
    writeUserInfo(balance: balance.value);
    writeShoppingCart();
    return true;
  }

  /// 增加-购物车数据
  bool removeShoppingCart(Goods bean) {
    if (!isLogin) return false;
    bool tempResult = shoppingCart.remove(bean);
    if (tempResult) {
      writeUserInfo(balance: balance.value);
      writeShoppingCart();
    }
    return tempResult;
  }

  /// 读取-订单数据
  void readOrderList() {
    if (!isLogin) return;
    String? temp = GetStorage().read(ORDER_LIST);
    if (temp != null) {
      List tempList = json.decode(temp);
      for (var element in tempList) {
        orderList.add(Goods(
          id: element['id'],
          title: element['title'],
          price: element['price'],
        ));
      }
    }
  }

  /// 存储-订单数据
  void writeOrderList() {
    if (!isLogin) return;
    GetStorage().write(ORDER_LIST, json.encode(orderList));
  }

  /// 存储-购物车数据
  bool addOrderList(Goods bean) {
    if (!isLogin) return false;
    if (!canBuy(bean.price)) return false;
    orderList.add(bean);
    balance -= bean.price;
    writeOrderList();
    return true;
  }

  /// 检查是否登入-跳转登入页
  void checkLoginAndCallback(VoidCallback successCallback) {
    if (isLogin) {
      successCallback();
      return;
    }
    Get.defaultDialog(
      title: '提示',
      content: const Text('是否前往登入?'),
      textConfirm: '去登入',
      onConfirm: () {
        Get.back();
        AppRouter.share.open(
          Paths.login,
          arguments: {'successCallback': successCallback},
        );
      },
    );
  }

  /// 登入
  void toLogin() {
    writeLogin(isLogin: true);
    readUserInfo();
    readUserInfo();
  }

  /// 登出
  void toLogout() {
    isLogin = false;
    balance.value = 0;
    shoppingCart.clear();
    orderList.clear();
    writeUserInfo();
  }
}
