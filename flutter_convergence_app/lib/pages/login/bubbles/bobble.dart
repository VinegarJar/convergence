import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';

///气泡属性配置
class BobbleBean {
  //位置
  Offset postion;

  //颜色
  Color color;

  //运动的速度
  double speed;

  //角度
  double theta;

  //半径
  double radius;
}

class CustomMyPainter extends CustomPainter {
  //创建画笔
  Paint _paint = Paint();

  //保存气泡的集合
  List<BobbleBean> list;

  //随机数变量
  Random random;

  CustomMyPainter({this.list, this.random});

  @override
  void paint(Canvas canvas, Size size) {
    //每次绘制都重新计算位置
    list.forEach((element) {
      //计算偏移
      var velocity = Utils.calculateXY(element.speed, element.theta);
      //新的坐标 微偏移
      var dx = element.postion.dx + velocity.dx;
      var dy = element.postion.dy + velocity.dy;
      //x轴边界计算
      if (element.postion.dx < 0 || element.postion.dx > size.width) {
        dx = random.nextDouble() * size.width;
      }
      //y轴边界计算
      if (element.postion.dy < 0 || element.postion.dy > size.height) {
        dy = random.nextDouble() * size.height;
      }
      //新的位置
      element.postion = Offset(dx, dy);

      // print("dx $dx dy $dy  ${element.postion}");
    });

    //循环绘制所有的气泡
    list.forEach((element) {
      //画笔颜色
      _paint.color = element.color;
      //绘制圆
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
