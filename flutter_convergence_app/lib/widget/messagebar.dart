import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

class MessageBar extends StatelessWidget {
  MessageBar({Key key}) : super(key: key);

  final List listData = [
  
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(88),
        width: ScreenUtil().setWidth(700),
        child:   MarqueeWidget(
            text: "平台承诺 1:首付最低一期最高三期、2:有无押金,有,芝麻分达到要求即可以免押、3:押金能否转租金,可以、4:全新国行手机、5:回访方式：微信+电话、6:优势,审核快,发货快。",
            textStyle: new TextStyle(fontSize: 15.0),
            scrollAxis: Axis.horizontal,
          )
    
      );
  
  }
}
