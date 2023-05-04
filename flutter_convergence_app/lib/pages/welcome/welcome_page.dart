
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Material(
        child: Container(
            color: Colors.white,
            child: Image(
              image: AssetImage(Utils.getImgPath('launch_image')),
              fit: BoxFit.contain,
            )));
  }
}
