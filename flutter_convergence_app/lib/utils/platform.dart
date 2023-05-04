import 'dart:core';
import 'dart:io';

/**标准单利写法*/

class PlatformUtils {
  PlatformUtils._internal();
  static bool  _isAndroid;
  static bool _isIos;
  static bool _isInstantiation = false;

  factory PlatformUtils() {
    if (!_isInstantiation) {
      _isAndroid = Platform.isAndroid;
      _isIos = Platform.isIOS;
      _isInstantiation = true;
    }

    return _instance;
  }

  static  final PlatformUtils _instance = PlatformUtils._internal();

  get isAndroid {
    return _isAndroid;
  }

  get isIOS {
    return _isIos;
  }
}
