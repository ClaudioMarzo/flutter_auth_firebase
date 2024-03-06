import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/style/text_styles.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        textAlign: TextAlign.start,
        "Pesquisar Item",
        style: TextStyles.i.textRegular.copyWith(fontSize: 18, color: ColorsCustom.i.red),
      ),
    );
  }
}
