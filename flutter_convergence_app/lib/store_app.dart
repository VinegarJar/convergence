import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/global/global.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/code.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';
import 'package:flutter_cityshop_store/pages/login/login_page.dart';
import 'package:flutter_cityshop_store/pages/welcome/welcome_page.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/router/routes_pages_name.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class StoreApp extends StatefulWidget {
  final String initPage;
  StoreApp({Key key, @required this.initPage}) : super(key: key);

  @override
  _StoreAppState createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> with HttpErrorListener {

  
  @override
  void initState() {
    super.initState();
    if (widget.initPage == RoutesPage.Application) {
      UserDao.initUserInfo().then((res) {

        
        if (res != null && res.result) {
          Provider.of<UserProvider>(context, listen: false)
              .savaUserInfoCache(res.data);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CommonProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          navigatorKey: Global.navigatorKey,
          debugShowCheckedModeBanner: false, //关闭显示debug模式
          builder: EasyLoading.init(), //全局初始化
          initialRoute: widget.initPage,
          routes: {
            RoutesPage.Welcome: (BuildContext context) => WelcomePage(),
            RoutesPage.Application: (BuildContext context) => IndexPages(),
            RoutesPage.Login: (BuildContext context) => LoginPage(),
          },
        ));
  }
}

//要指定(State这个类能使用HttpErrorListener这个混入的类)只有某些类型可以使用mixin。例如所以你的mixin可以调用它没有定义的方法,用于on指定所需的超类
mixin HttpErrorListener on State<StoreApp> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  void logOutAction() async {
    Future.delayed(Duration(seconds: 0)).then((onValue) {
      BuildContext context = Global.navigatorKey.currentState.overlay.context;
      NavigatorUtils.goLogin(context);
    });

    await LocalStorage.remove(Config.TOKEN_KEY);
    await LocalStorage.remove(Config.USER_INFO);
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast("网络错误");
        break;
      case 401:
        showToast("网络错误401");
        // logOutAction();
        break;
      case 403:
        showToast("网络错误403");
        break;
      case 404:
        showToast("网络错误404");
        // logOutAction();
        break;
      case 422:
        showToast("网络错误422");
        logOutAction();
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast("网络连接异常");
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        showToast("网络请求异常,请检查网络!");
        break;
      default:
        showToast(message);
        break;
    }
  }

  showToast(String message) {
    EasyLoading.dismiss();
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG);
  }
}
