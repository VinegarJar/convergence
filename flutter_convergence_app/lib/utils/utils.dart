import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/models.dart';

class Utils {
  static String getImgPath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getHtmlPath(String name, {String format = 'html'}) {
    return 'assets/html/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    // ignore: deprecated_member_use
    // Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(msg),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  static Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  static Widget getListItem(BuildContext context, CityModel model,
      {double susHeight = 40}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: getSusItem(context, model.getSuspensionTag(),
              susHeight: susHeight),
        ),
        ListTile(
          title: Text(model.name),
          onTap: () {
            //LogUtil.e("onItemClick : $model");
            Utils.showSnackBar(context, 'onItemClick : ${model.name}');
          },
        )
      ],
    );
  }

  static Widget getWeChatListItem(
    BuildContext context,
    ContactInfo model, {
    double susHeight = 40,
    Color defHeaderBgColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: getSusItem(context, model.getSuspensionTag(),
              susHeight: susHeight),
        ),
        getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor),
      ],
    );
  }

  static Widget getWeChatItem(
    BuildContext context,
    ContactInfo model, {
    Color defHeaderBgColor,
  }) {
    DecorationImage image;
//    if (model.img != null && model.img.isNotEmpty) {
//      image = DecorationImage(
//        image: CachedNetworkImageProvider(model.img),
//        fit: BoxFit.contain,
//      );
//    }
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
          color: model.bgColor ?? defHeaderBgColor,
          image: image,
        ),
        child: model.iconData == null
            ? null
            : Icon(
                model.iconData,
                color: Colors.white,
                size: 20,
              ),
      ),
      title: Text(model.name),
      onTap: () {
        //LogUtil.e("onItemClick : $model");
        Utils.showSnackBar(context, 'onItemClick : ${model.name}');
      },
    );
  }

  ///获取随机透明的白色
  static Color getRandonWhightColor(Random random) {
    //0~255 0为完全透明 255 为不透明
    //这里生成的透明度取值范围为 10~200
    int a = random.nextInt(190) + 10;
    return Color.fromARGB(a, 255, 255, 255);
  }

  ///获取随机颜色
  static Color getRandonColor(Random random) {
    var a = random.nextInt(255);
    var r = random.nextInt(255);
    var g = random.nextInt(255);
    var b = random.nextInt(255);
    return Color.fromARGB(a, r, g, b);
  }

  ///计算坐标
  static Offset calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }
}
