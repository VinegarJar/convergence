import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/global/global.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/pages/login/bubbles/bobble.dart';
import 'package:flutter_cityshop_store/pages/login/login_agree.dart';
import 'package:flutter_cityshop_store/pages/login/login_botton.dart';
import 'package:flutter_cityshop_store/pages/login/login_input.dart';
import 'package:flutter_cityshop_store/pages/login/login_logo.dart';
import 'package:flutter_cityshop_store/pages/login/login_msgCode_input.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: LoginHomePage(),
    );
  }
}

class LoginHomePage extends StatefulWidget {
  LoginHomePage({Key key}) : super(key: key);

  @override
  _LoginHomePageState createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage>
    with SingleTickerProviderStateMixin {
  //随机数据
  Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  //创建的气泡保存集合
  List<BobbleBean> _list = [];

  //气泡的最大半径
  double maxRadius = 100;

  //气泡动画的最大速度
  double maxSpeed = 0.7;

  //气泡计算使用的最大弧度（360度）
  double maxTheta = 2.0 * pi;

  //动画控制器
  AnimationController _animationController;

  final TextEditingController _editTextController = TextEditingController();

  String _phoneNum = "";
  String _smsCode = "";
  bool _checked = false;

  void loadPolicySheet() async {
    final policy = await LocalStorage.get("policy");
    if (policy != "1") {
      BuildContext context = Global.navigatorKey.currentState.overlay.context;
      Alert.showPolicySheet(context: context, onPressed: () {});
    }
  }

  /*初始化函数中创建气泡*/
  BobbleBean getRandonWhightBobbleBean() {
    BobbleBean particle = BobbleBean();
    //获取随机透明度的白色颜色
    particle.color = Utils.getRandonWhightColor(_random);
    //指定一个位置 每次绘制时还会修改
    particle.postion = Offset(-1, -1);
    //气泡运动速度
    particle.speed = _random.nextDouble() * maxSpeed;
    //随机角度
    particle.theta = _random.nextDouble() * maxTheta;
    //随机半径
    particle.radius = _random.nextDouble() * maxRadius;
    return particle;
  }

  @override
  void initState() {
    super.initState();
    _list = List.generate(10, (index) => getRandonWhightBobbleBean());

    /*重复执行repeat()**/
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..repeat();

    loadPolicySheet();
    _editTextController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _editTextController.removeListener(_onQueryChanged);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LoginHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget != oldWidget) {
      _editTextController.removeListener(_onQueryChanged);
      _editTextController.addListener(_onQueryChanged);
    }
  }

  void _onQueryChanged() {
    _inputChanged(_editTextController.text);
  }

  void _inputChanged(String text) {
    _smsCode = text;
    BlocProvider.of<LoginBloc>(context).add(LoginChangeEvent(phoneNum: text));
  }

  //第二部分 第二层 气泡
  Widget buildBubble(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        //自定义画板
        return CustomPaint(
          //自定义画布
          painter: CustomMyPainter(
            list: _list,
            random: _random,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              LoginLogo(),
              LoginMsgCodeInput(
                hintText: "请输入手机号",
                onChanged: (String value) {
                  _phoneNum = value;
                },
              ),
              SizedBox(height: ScreenUtil().setWidth(20)),
              LoginInput(
                hintText: "请输入验证码",
                controller: _editTextController,
                onChanged: (String value) {
                  _inputChanged(value);
                },
              ),
              SizedBox(height: ScreenUtil().setWidth(35)),
              LoginBotton(onPressed: () async {
                final policy = await LocalStorage.get("policy");
                if (policy != "1") {
                  BuildContext context =
                        Global.navigatorKey.currentState.overlay.context;
                  Alert.showPolicySheet(context: context, onPressed: () {});
                } else {
                  _loginRequest();
                }
              }),
              SizedBox(height: ScreenUtil().setWidth(35)),
              LoginAgree(
                onProtocol: (bool checked) {
                  print('是否勾选----$checked');
                  _checked = checked;
                },
              ),
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(
            //渐变角度
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            //渐变颜色组 #43D0E9 #7ADEEF  #61D8EC
            colors: [
              Color(0xFF43D0E9),
              Color(0xFF43D0E9),
              Color(0xFF7ADEEF),
            ],
          ),
        ),
        child: buildBubble(context),
      ))),
    );
  }

  void _loginRequest() async {
    if (!_checked) {
      return eventBus.fire(new HttpErrorEvent(99, "请勾选我已阅读并同意接受协议"));
    }
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(_phoneNum);
    if (matched) {
      await EasyLoading.show(
        status: '登陆中...',
        maskType: EasyLoadingMaskType.black,
      );
      var params = {
        "phoneNum": _phoneNum,
        "smsCode": _smsCode,
        "channelId": "vivo"
        // "channelId": "huawei"
      };
      if (Platform.isAndroid) {
        params['androidVisited'] = "1";
      } else {
        params['iosVisited'] = "1";
      }

      var res = await HttpRequestMethod.instance
          .requestWithMetod(Config.loginUrl, params);
      print("-----登陆数据---->${res.data}");
      var data = res.data ?? {};

      if (data["code"] == 200) {
        getUserInfo();
        _inputChanged("");
      } else {
        eventBus.fire(new HttpErrorEvent(99, data["msg"] ?? "验证码有误"));
        EasyLoading.dismiss();
      }
    } else {
      eventBus.fire(new HttpErrorEvent(99, "输入手机号有误,请重新输入!"));
    }
  }

  getUserInfo() async {
    var params = {"phoneNum": _phoneNum};
    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.userInfo, params);

    UserInfo user = UserInfo.fromJson(res.data);
    print('获取用户信息----user----${user.realNameVerify}');
    print('获取用户nickName----user----${user.nickName}');
    Provider.of<UserProvider>(context, listen: false).savaUserInfoCache(user);
    LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
    LocalStorage.save(Config.TOKEN_KEY, user.phoneNum);
    LocalStorage.save(Config.USER_VIP, user.vipLevel.toString());
    EasyLoading.dismiss();
    NavigatorUtils.goHome(context);
  }
}
