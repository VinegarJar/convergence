import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/pages/mine/comoment/mine_banner.dart';
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
          InkWell(
            // ignore: deprecated_member_use
            onTap: () => launch("tel://18072302640"),
            child: Container(
                color: Colors.white,
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setWidth(100),
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(20),
                    horizontal: ScreenUtil().setWidth(40)),
                child: Text("在线客服电话:18072302640",
                    style: TextStyle(
                        color: ThemeColors.appliedColor,
                        fontSize: ScreenUtil().setSp(38)))),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(40),
          ),
          MineBanner(),
        ]),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}