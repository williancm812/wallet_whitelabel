

import 'package:flutter/material.dart';

void showInSnackBar(
  BuildContext? context,
  String? s, {
  Color? color = const Color(0xffEB5757),
  double? fontSize = 14,
  Duration? duration,
}) {
  if(context == null) return;
  if(s == null) return;
  if(color == null) return;
  if(fontSize == null) return;


  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(_snackBar(
    s,
    color: color,
    fontSize: fontSize,
    duration: duration,
  ));
}

_snackBar(
  String s, {
  @required Color? color,
  @required double? fontSize,
  @required Duration? duration,
}) {
  return SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(seconds: 4),
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize),
      ),
    );
}
