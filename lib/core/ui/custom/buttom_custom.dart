import 'package:flutter/material.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/style/text_styles.dart';

class ButtonCustom extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;

  const ButtonCustom({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = 142,
    this.height = 48,
  });

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.width ?? 0,
        minHeight: widget.height ?? 0,
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsCustom.i.blue),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: Text(
          textAlign: TextAlign.center,
          widget.label,
          style: TextStyles.i.textRegular
              .copyWith(fontSize: 14, color: ColorsCustom.i.white),
        ),
      ),
    );
  }
}
