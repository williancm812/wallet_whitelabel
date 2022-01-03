

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';

class LineHigher extends StatelessWidget {
  final String? text;
  Color? textColor;
  final String? image;
  final Color? imageColor;
  final double? textSize;
  final IconData? icon;
  final IconData? finalIcon;
  final VoidCallback? onFinalTap;
  final VoidCallback? onPrimaryTap;
  final Color? finalIconColor;
  Color? backgroundLineHigher;
  Color? containerColor;


  LineHigher({
    Key? key,
    this.text = 'Crie sua conta',
    this.textColor,
    this.icon = Icons.arrow_back_ios,
    this.imageColor,
    this.textSize = 22,
    this.finalIcon,
    this.image = 'assets/images/ic_cash_edu_logo.svg',
    this.onFinalTap,
    this.onPrimaryTap,
    this.finalIconColor = Colors.white,
    this.backgroundLineHigher,
    this.containerColor,



  }) : super(key: key){
   textColor ??= AppController().lineHigherTextColor;
   backgroundLineHigher ??= AppController().lineHigherColor;
   containerColor ??= AppController().secondPrincipalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundLineHigher,
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: 16),
          InkWell(
            onTap: onPrimaryTap ??  () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: containerColor,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          const Spacer(),
          Text(
            text!,
            style: GoogleFonts.roboto(color: textColor, fontSize: textSize),
          ),
          const Spacer(),
          InkWell(
            onTap: onFinalTap,
            child: Icon(
              finalIcon,
              color: finalIconColor,
            ),
          ),
          const SizedBox(width: 20,),
        ],
      ),
    );
  }
}
