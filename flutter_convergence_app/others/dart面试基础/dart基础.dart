// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';

//ColorFiltered  处理界面变灰效果 https://juejin.cn/post/7174782662182174781

class Person {
  /*私有变量,必须The final  '_name' must be initialized. 要初始化,赋值， final只能赋一次值 */
  final String _name = "字符串";
  /*公开变量, 使用final申明变量了,必须要初始化,赋值， final只能赋一次值 */
  final int count = 0;
  //可以只申明,不用初始化赋值
  int member = 1;

  static final test = 10;

  _privateAdd() {
    /**
    * 'count' can't be used as a setter because it's final.Try
       finding a different setter, or making 'count' non-final.d
       不能给 count值的改变了 
       count += 1; 
    */

    member += 1;
    print("输出私有方法中数据变化$member");
  }

  Prints() {
    return _privateAdd();
  }

  /*如果在其他路径被外部调用会有警告*/
  @protected
  handleRefresh() {
    print("如果在其他路径被外部调用会有警告");
  }
}

//扩展内置类
extension StingExtension on String {
  //将字符串数字转换为数字

  parseInt() {
    return int.parse(this);
  }
}

//call方法,当我们将类的实例,用作函数时,会自动调用call方法
class Phones {
  call(String num) {
    print("当我们将类的实例,用作函数时,会自动调用call方法");
  }
}

//typedef Type Name(params);自定义类型的别名,让程序的可读性更强,更加方便

//hashCode是对象的唯一标识别,通过hasCode判断对象是否相等
void main() async {
  // Person person1;

  // Person person2 = Person();
  // person2.member = 0;

  // Person person3 = Person()
  //   .._name
  //   .._privateAdd()
  //   ..Prints()
  //   ..handleRefresh();

  // print("--$person2---$person3");
}
