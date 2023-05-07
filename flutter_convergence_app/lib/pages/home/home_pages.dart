import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/https/result_data.dart';
import 'package:flutter_cityshop_store/model/advert.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/pages/home/home_list_page.dart';
import 'package:flutter_cityshop_store/pages/home/home_title.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/home_banner.dart';
import 'package:flutter_cityshop_store/widget/placeitem.dart';
import 'package:flutter_cityshop_store/widget/tag.dart';


class HomePages extends StatefulWidget {
  HomePages({Key key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages>
    with AutomaticKeepAliveClientMixin {
//保持 保持原页面State 状态 AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;

  var params = {};
  List<Advert> banner = [];

  @override
  void initState() {
    super.initState();
     if (Platform.isAndroid) {
      params['isAndroid'] = "1";
    } else {
      params['isIos'] = "1";
    }
    params['pageSize'] = 20;
    params['pageNum'] = 1;
    requstAdvert();
  }

  void requstAdvert() async {
    HttpRequestMethod.instance
        .requestWithMetod(Config.todayRecommed, params)
        .then((res) {
         ResultData result = res as ResultData;
        if (result.code ==  200) {
          final List<Advert> dataSource = [Advert.fromJson(result.data)]; 
          print('dataSource----$dataSource');
           setState(() {
                 banner = dataSource;
           });      
        }
       print('requstAdvert----${result.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0, // 隐藏阴影
          backgroundColor: ThemeColors.homemainColor,
          title: HomeTitle()),
      body: FutureBuilder(
        future: HttpRequestMethod.instance
            .requestWithMetod(Config.homeBankUrl,params),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            ResultData result = snapshot.data as ResultData;
            
            final  List  list = result.data["list"];
            final List dataSource =
                list.map((data) => HomeRecommed.fromJson(data)).toList(); 
            return  ListView(
                  children: [
                    HomeBanner(bannner: banner, callBack: () {}),
                    Tage(titel: "特别推荐",subtitel: " (同时申请五款以上,通过率越高)",),
                    HomeListPage(dataSource: dataSource)
                  ],
                );
          } else {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return PlaceItem();
              },
            );
          }
        },
      ),
    );
  }
}
