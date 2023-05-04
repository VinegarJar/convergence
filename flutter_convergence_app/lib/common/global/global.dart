/*全局静态数据,公用*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Global {

  //全局公共GlobalKey
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //设置禁止横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        //这是设置状态栏的图标和字体的颜色
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    HttpOverrides.global = new MyHttpOverrides();
  }
}


class MyHttpOverrides extends HttpOverrides {
  //一种跳过SSL认证问题并解决Image.network(url)问题的方法是使用以下代码：
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
