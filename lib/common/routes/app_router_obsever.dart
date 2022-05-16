import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/logger/logger_utils.dart';

///路由处理
String _extractRouteName(Route? route) {
  if (route == null) return '';
  String? tempName = route.settings.name;
  return tempName ?? 'unKnow_name_${route.hashCode}';
}

///路由监听
class AppRouter extends RouteObserver<Route> {
  //禁止直接实例化
  AppRouter._();

  static AppRouter share = AppRouter._();

  ///当前路由
  String get currentRoute {
    if (pageRoute.isEmpty) return '';
    return pageRoute.last;
  }

  ///上一个
  String get previousRoute {
    if (pageRoute.length <= 1) return '';
    return pageRoute[pageRoute.length - 2];
  }

  ///页面路由
  List<String> pageRoute = [];

  void resetPageRoute() {
    pageRoute = ['/main'];
  }

  ///打开页面
  Future<dynamic> open(
    String pageName, {
    Object? arguments,
    bool preventDuplicates = false,
  }) async {
    pageRoute.add(pageName);
    return Get.toNamed(
      pageName,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
    );
  }

  ///替换页面
  Future<dynamic> replace(String pageName, {Object? arguments}) async {
    pageRoute[pageRoute.length - 1] = pageName;
    return Get.offNamed(pageName, arguments: arguments);
  }

  ///打开并关闭前面部分页面
  Future<dynamic> until(String pageName, String predicate,
      {Object? arguments}) async {
    int index = pageRoute.length - 1;
    pageRoute.add(pageName);
    while (index >= 0 && pageRoute[index] != predicate) {
      if (pageRoute.contains(pageRoute[index])) {
        pageRoute.removeAt(index);
      }
      index -= 1;
    }
    return Get.offNamedUntil(
      pageName,
      (Route<dynamic> route) => route.settings.name == predicate,
      arguments: arguments,
    );
  }

  /// 关闭
  void close({dynamic result}) {
    Get.back(result: result);
  }

  ///执行push时-调用
  ///参数：
  ///route：去往页面
  ///previousRoute：来至页面
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    Logger.write('** didPush **'
        '\n当前路由:$currentRoute'
        '\n上一个路由-绝对:${this.previousRoute}'
        '\npageRoute=${pageRoute.toString()}');
  }

  ///执行pop时-调用
  ///参数：
  ///route：来至页面
  ///previousRoute：去往页面
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    pageRoute.removeLast();
    debugPrint('** didPop **'
        '\n当前路由:$currentRoute'
        '\n上一个路由:${this.previousRoute}'
        '\npageRoute=${pageRoute.toString()}');
  }

  ///执行offUntil时-调用
  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);

    debugPrint('** didRemove **'
        '\n当前路由:$currentRoute'
        '\n上一个路由:${this.previousRoute}'
        '\npageRoute=${pageRoute.toString()}');
  }

  ///
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint('** didReplace **'
        '\n当前路由:$currentRoute'
        '\n上一个路由:$previousRoute'
        '\npageRoute=${pageRoute.toString()}');
  }

  @override
  bool debugObservingRoute(Route route) {
    // Logger.write('** debugObservingRoute **'
    //     '\nroute:${route.settings.name}');
    return super.debugObservingRoute(route);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // Logger.write('** didStartUserGesture **'
    //     '\nflutter:'
    //     '\nroute:${route.settings.name}'
    //     '\npreviousRoute:${previousRoute?.settings.name}'
    //     '\nGet:'
    //     '\nroute:${Get.currentRoute}'
    //     '\npreviousRoute:${Get.previousRoute}');
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    debugPrint('** didStopUserGesture **');
    super.didStopUserGesture();
  }

  @override
  void subscribe(RouteAware routeAware, Route route) {
    debugPrint('** subscribe **'
        '\nroute:${route.settings.name}');
    super.subscribe(routeAware, route);
  }

  @override
  void unsubscribe(RouteAware routeAware) {
    debugPrint('** unsubscribe **');
    super.unsubscribe(routeAware);
  }
}
