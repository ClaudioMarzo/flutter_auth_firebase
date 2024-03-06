import 'package:flutter/material.dart';

class ColorsCustom {
  static ColorsCustom? _instance;

  ColorsCustom._();

  static ColorsCustom get i {
    _instance ??= ColorsCustom._();
    return _instance!;
  }

  Color get white => const Color.fromRGBO(255, 255, 255, 1);
  Color get black => const Color.fromRGBO(0, 0, 0, 1);
  Color get blue => const Color.fromRGBO(2, 134, 209, 1);
  Color get darkblue => const Color.fromRGBO(0, 71, 165, 1);
  Color get lightblue => const Color.fromRGBO(206, 229, 255, 1);
  Color get red => const Color.fromRGBO(189, 0, 13, 1);
  Color get gree => const Color.fromRGBO(35, 198, 83, 1);
  Color get lightgree => const Color.fromRGBO(95, 217, 112, 1);
  Color get darkgree => const Color.fromRGBO(0, 73, 26, 1);
  Color get grey => const Color.fromRGBO(132, 138, 144, 1);
  Color get yellow => const Color.fromRGBO(255, 186, 67, 1);
}

extension ColorsAppExtension on BuildContext {
  ColorsCustom get colors => ColorsCustom.i;
}
