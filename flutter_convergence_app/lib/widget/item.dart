import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class Item extends StatelessWidget {
  final HomeRecommed model;

  const Item({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setWidth(10)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setHeight(45),
                    decoration: BoxDecoration(
                        color: ThemeColors.mainBgColor,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                            image: NetworkImage(model.productImgUrl)),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(5))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(10)),
                    child: Text(
                      model?.productName ?? "",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: 5,vertical:4),
                    decoration: BoxDecoration(
                        color: ThemeColors.homeColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      model?.shortContent ?? "审核快",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: ThemeColors.subtitlesColor),
                    ),
                  ),
                  Container(
              margin: EdgeInsets.symmetric(
                        horizontal: 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: 5,vertical:4),
                    decoration: BoxDecoration(
                        color: ThemeColors.brandColor,
                        borderRadius:
                            BorderRadius.circular(4)),
                    child: Text(
                      timerContent(
                          model?.loanPeriodLower, model?.loanPeriodUpper),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(23),
                          color: ThemeColors.brandtitleColor),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      computeLongContent(model?.loanLower, model?.loanUpper),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.loanUpperColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                    child: Text(
                      computedownload(model?.applyNum),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  OnTopBotton(
                    callBack: () {
                      bool isReal =
                          Provider.of<UserProvider>(context, listen: false)
                              .isReal;
                      if (isReal) {
                        jumpWebView(context);
                      } else {
                        Alert.showDialogSheet(context: context);
                      }
                    },
                    title: "立即申请",
                    widget: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(35)),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ThemeColors.homemainColor,
                          borderRadius:
                              BorderRadius.circular(15)),
                      child: Text("立即申请",
                          style: TextStyle(
                            fontSize: 13,
                            color:Color(0xFFFFFFFF), //35,17,0
                          )),
                    ),
                  )
                ],
              )),
          Container(
            child: Text("最快" + model?.loanSpeed ?? "",
                style: TextStyle(
                  fontSize: 14,
                  color: ThemeColors.titleColor,
                )),
          )
        ],
      ),
    );
  }

  computeLongContent(var minimum, var maximum) {
    String min = "";
    if (minimum != null && minimum > 10000) {
      min = (minimum / 10000).truncate().toString() + "万";
    } else {
      min = minimum?.toString() ?? "0";
    }
    String max;
    if (maximum != null && maximum > 10000) {
      max = (maximum / 10000).truncate().toString() + "万";
    } else {
      max = maximum?.toString() ?? "0";
    }
    return ("日租最低" + max + "元");
  }

  timerContent(var loanPeriodLower, var loanPeriodUpper) {
    if (loanPeriodLower.toString().length > 3) {
      return ("3" + "~" + "12月");
    }
    return ("期限" +
        loanPeriodLower.toString() +
        "~" +
        loanPeriodUpper.toString() +
        "个月");
  }

  computedownload(var applyNum) {
    return (applyNum?.toString() ?? "0") + "人下载";
  }

  void jumpWebView(BuildContext context) async {
    UserDao.jumpWebView(context, model.productId);
  }
}
