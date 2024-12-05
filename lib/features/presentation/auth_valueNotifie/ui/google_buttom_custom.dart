import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';

class GoogleButtomCustom extends StatelessWidget {
  final String imagePath;
  final double heightImage;
  final Function()? onTap;
  const GoogleButtomCustom({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.heightImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsCustom.i.blue,
            width: 0.3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16),
          color: ColorsCustom.i.white,
        ),
        child: Image.asset(
          imagePath,
          height: heightImage,
        ),
      ),
    );
  }
}
