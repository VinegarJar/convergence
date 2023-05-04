/*自定义转场动画效果,路由动画底部弹出*/

import 'package:flutter/material.dart';

class CustomRouteAnimation extends PageRouteBuilder {
  final Widget routePage;
  CustomRouteAnimation({@required this.routePage})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                routePage,
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              final curveTween = CurveTween(curve: Curves.easeOutQuint);
              final tween = Tween(begin: const Offset(0, 1), end: Offset.zero)
                  .chain(curveTween);
              return SlideTransition(
                child: child,
                position: animation.drive(tween),
              );
            });
}
