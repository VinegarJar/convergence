import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tage extends StatelessWidget {
  final String titel;
    final String subtitel;
  const Tage({Key key, this.titel = "推荐产品", this.subtitel = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(10)),
      child:Row(
        children: [
           Text(titel,
          style: TextStyle(
              color: ThemeColors.jionColor, fontSize: ScreenUtil().setSp(36))),
          Text(subtitel,
          style: TextStyle(
              color: ThemeColors.titleColor, fontSize: ScreenUtil().setSp(32)))     
        ],
      ),
    );
  }
}
