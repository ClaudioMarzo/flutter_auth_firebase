import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';

class AuthButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget loading;

  final double buttomWidth;
  final double buttomHeight;

  const AuthButtonCustom({
    super.key,
    required this.onPressed,
    required this.buttomWidth,
    required this.buttomHeight,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: buttomWidth,
        minHeight: buttomHeight,
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
