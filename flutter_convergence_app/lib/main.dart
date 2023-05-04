import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/global/global.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/router/routes_pages_name.dart';
import 'package:flutter_cityshop_store/store_app.dart';


void main() async {
  await Global.init();
  await realRunApp();

}

void realRunApp() async {
  bool isLogin = await UserDao.getLoginStatus();
    if (isLogin) {
      runApp( StoreApp(initPage: RoutesPage.Application));
    } else {
      runApp( StoreApp(initPage: RoutesPage.Login));
    }
}
