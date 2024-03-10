import 'package:flutter/material.dart';

import 'package:katyfestascatalog/core/ui/style/color_style.dart';

class CircularprogressCustom extends StatelessWidget {
  final double width;

  const CircularprogressCustom({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: width,
      color: ColorsCustom.i.white,
    );
  }
}
