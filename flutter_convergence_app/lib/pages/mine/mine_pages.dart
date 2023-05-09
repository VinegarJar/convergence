// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/pages/mine/comoment/mine_head_ground.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MinePages extends StatefulWidget {
  MinePages({Key key}) : super(key: key);

  @override
  _MinePagesState createState() => _MinePagesState();
}

class _MinePagesState extends State<MinePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          MineHeadGround(
            callBack: () {
              bool isReal = Provider.of<UserProvider>(context).isReal;
              bool isVIP = Provider.of<UserProvider>(context).isVIP;

              if (isReal) {
                if (isVIP) {
                  NavigatorUtils.gotoAssociatorPages(context);
                } else {
                  print("点击跳转vip购买---");
                  NavigatorUtils.gotoVipPages(context);
                }
              } else {
                Alert.showDialogSheet(context: context);
              }
            },
            onPressed: () {
              NavigatorUtils.gotoUserSystem(context);
            },
          ),
          Column(mainAxisSize: MainAxisSize.min, children: _wrapList(context)),
        ]),
      ),

    );
  }

  final name = Config.dict["name"];
  List<Widget> _wrapList(context) {
    List tabs = [
      {"title": "在线客服电话:18072302640", "path": Null},
      {"title": "$name隐私政策", "path": Config.dict["privacyUrl"]},
      {"title": "知情告知书", "path": Config.dict["noticeUrl"]},
      {"title": "个人信息授权使用声明", "path": Config.dict["authorizationUrl"]},
      {"title": "欢迎您注册和使用$name的服务", "path": Config.dict["agreementUrl"]},
    ];

    final List listWidget = tabs.map((results) {
      return InkWell(
          onTap: () async {
            print("跳转链接--${results["path"]}");
            var path = results["path"];
            if (path == Null) {
              launch("tel://18072302640");
            } else {
              NavigatorUtils.goWebView(
                  context, results["path"], results["title"]);
            }
          },
          child: Container(
            color: Colors.white,
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.symmetric(vertical: 15),
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(25)),
                  child: Text(
                    results["title"],
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                  child: Icon(Icons.arrow_forward_ios_sharp,
                      size: ScreenUtil().setSp(32),
                      color: ThemeColors.titlesColor),
                ),
              ],
            ),
          ));
    }).toList();
    return listWidget;
  }
}
