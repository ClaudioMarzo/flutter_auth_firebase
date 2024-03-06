import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';

class SquareButtomCustom extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareButtomCustom({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsCustom.i.white),
          borderRadius: BorderRadius.circular(16),
          color: ColorsCustom.i.white,
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
