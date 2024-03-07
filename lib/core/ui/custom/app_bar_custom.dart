import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/style/text_styles.dart';

class AppBarCustom extends AppBar {
  late String titletext;
  late bool isExit;
  late Function()? onPressed;
  AppBarCustom({
    required this.isExit,
    required this.titletext,
    this.onPressed,
    super.key,
  }) : super(
          elevation: 0,
          toolbarHeight: 94,
          title: Center(
            child: Text(
              titletext,
              textAlign: TextAlign.center,
              style: TextStyles.i.textExtraBold.copyWith(fontSize: 30, color: ColorsCustom.i.white),
            ),
          ),
          actions: <Widget>[
            isExit == false
                ? IconButton(
                    onPressed: onPressed,
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(
                        Icons.logout,
                        size: 40,
                        color: ColorsCustom.i.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
}
