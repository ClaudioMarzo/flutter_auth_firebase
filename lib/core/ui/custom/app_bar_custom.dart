import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:katyfestascatalog/core/ui/style/color_style.dart';
import 'package:katyfestascatalog/core/ui/style/text_styles.dart';
import 'package:katyfestascatalog/features/presentation/home/home_controller.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onPressedSign;
  final Function()? onPressedOut;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onPressedSign,
    required this.onPressedOut,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Color textColor = ColorsCustom.i.white;
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width > 600;
    Size screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: ColorsCustom.i.red,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyles.i.textExtraBold.copyWith(fontSize: 30, color: ColorsCustom.i.white),
                  ),
                ],
              ),
            ),
            if (isSmallScreen)
              if(widget.onPressedSign != null)
                InkWell(
                  onTap: widget.onPressedSign,
                  child: Text(
                    'Inscrever-se',
                    style: TextStyles.i.textButtonLabel.copyWith(fontSize: 20, color: ColorsCustom.i.white),
                  ),
                ),
            SizedBox(width: screenSize.width / 50),
            if (isSmallScreen)
              Consumer<HomeController>(
                builder: (context, controller, child) {
                  return MouseRegion(
                    onEnter: (_) => setState(() => textColor = ColorsCustom.i.darkblue),
                    onExit: (_) => setState(() => textColor = ColorsCustom.i.white),
                    child: InkWell(
                      onTap: widget.onPressedOut,
                      child: Text(
                        'Sair',
                        style: TextStyles.i.textButtonLabel.copyWith(fontSize: 20, color: textColor),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}