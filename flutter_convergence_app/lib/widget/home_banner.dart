import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/model/advert.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatelessWidget {
  final List bannner;
  final bool jump;
  final VoidCallback callBack;
  HomeBanner({
    @required this.bannner,
    this.jump = true,
    this.callBack,
  });

  void jumpToRealName(BuildContext context, var productId) async {
    bool isReal = Provider.of<UserProvider>(context, listen: false).isReal;

    if (isReal) {
      UserDao.jumpWebView(context, productId);
    } else {
      Alert.showDialogSheet(
          context: context,
          onPressed: (Map<String, dynamic> result) {
            print("弹框关闭 $result");
            //MessageBar messagebar
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(365),
        width: ScreenUtil().setWidth(750),
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(15),
            vertical: ScreenUtil().setWidth(20)),
        child: Swiper(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Advert model = bannner.length > 0 ? bannner[index] : null;
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          ExactAssetImage(Utils.getImgPath('placeholderImg')),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleWidget(model),
                  SizedBox(height: 180.w,), 
                  model != null
                      ? OnTopBotton(
                          callBack: () {
                            jumpToRealName(context, model.productId);
                          },
                          title: "立即下单",
                          widget: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(40),
                            ),
                            height: ScreenUtil().setWidth(88),
                            decoration: BoxDecoration(
                                color: ThemeColors.homemainColor,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(44))),
                            child: Text("立即下单",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  color: ThemeColors.whiteColor, //35,17,0
                                )),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          },

          itemCount: 1,
          scrollDirection: Axis.horizontal,
          autoplay: false,
          onIndexChanged: (index) {},
          scale: 0.95, // 两张图片之间的间隔
          onTap: (index) {
            print('点击了第$index个');
          },
          // 展示窗口模式viewportFraction: 0.8,
        ));
  }

  computeLongContent(var minimum, var maximum) {
    String min;
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
    return "租期长" + (min + "~" + max) + "个月";
  }

  Widget _titleWidget(Advert model) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20)),
            child: Text(
              model?.productName ?? "",
              style: TextStyle(
                  fontSize: 34.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          
        ),
        Container(
          margin: EdgeInsets.only(top: 50.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
           decoration: BoxDecoration(
            border: Border.all(
                color:Colors.white, width: 0.8),
            borderRadius: BorderRadius.circular(10.w)),
          child:Text(
              "免押金",
              style: TextStyle(
                  fontSize: 23.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50.w,left: 15.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
           decoration: BoxDecoration(
            border: Border.all(
                color:Colors.white, width: 0.8),
            borderRadius: BorderRadius.circular(10.w)),
          child:Text(
              "审核快",
              style: TextStyle(
                  fontSize: 23.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
        ),
               Container(
          margin: EdgeInsets.only(top: 50.w,left: 15.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
           decoration: BoxDecoration(
            border: Border.all(
                color:Colors.white, width: 0.8),
            borderRadius: BorderRadius.circular(10.w)),
          child:Text(
              computeLongContent(
                              model?.loanLower, model?.loanUpper),
              style: TextStyle(
                  fontSize: 23.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
        ),
      ],
    );
  }
}
