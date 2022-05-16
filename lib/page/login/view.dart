import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/services/user_info_service.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登入页'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('登入'),
          onPressed: () {
            UserInfoService.to.toLogin();
            print('test 111');
            if (state.successCallback != null) {
              print('test 222');
              state.successCallback!();
            }
            print('test 3333');
            Get.back();
            print('test 4444');
          },
        ),
      ),
    );
  }
}
