import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';

class AuthButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget loading;

  final double? width;
  final double? height;

  const AuthButtonCustom({
    super.key,
    required this.onPressed,
    this.width = 142,
    this.height = 48,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width ?? 0,
        minHeight: height ?? 0,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsCustom.i.blue),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: loading,
      ),
    );
  }
}
