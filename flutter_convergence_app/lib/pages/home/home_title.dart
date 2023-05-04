import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTitle extends StatelessWidget {
  final name = Config.dict["name"];

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment : CrossAxisAlignment.start,
      children: [
      Text(
            "$name",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(38)),
          ),
         Text(
            "通过率高 审核快 当天发货",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontSize: ScreenUtil().setSp(28)),
          ),
      ],
    );
  }
}
