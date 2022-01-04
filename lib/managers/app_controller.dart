import 'dart:ui';

import 'package:flutter/material.dart';

class AppController {
  static final AppController _instance = AppController.internal();

  factory AppController() => _instance;

  AppController.internal();

  void initialize({
    @required Color? errorColor,
    @required Color? desabilitedColor,
    @required Color? lineHigherColor,
    @required Color? lineHigherTextColor,
    @required Color? secondPrincipalColor,
    @required Color? buttonConfig,
    @required Color? buttonDesabilited,
    @required Color? lineContainerContactColor,
    @required Color? lineContactColor,
    @required Color? colorInput,
    @required Color? containerHomeColor,
    @required Color? iconColorBlack,
    @required Color? backgroundFirst,
    @required Color? backgroundSecond,
    @required Color? backgroundThird,
    @required Color? letterColor,
    @required Color? colorTextInput,
    @required Color? textBlack,
    @required Color? textWhite,
  }) {
    this.errorColor = errorColor;
    this.desabilitedColor = desabilitedColor;
    this.lineHigherColor = lineHigherColor;
    this.lineHigherTextColor = lineHigherTextColor;
    this.secondPrincipalColor = secondPrincipalColor;
    this.buttonConfig = buttonConfig;
    this.buttonDesabilited = buttonDesabilited;
    this.lineContainerContactColor = lineContainerContactColor;
    this.lineContactColor = lineContactColor;
    this.colorInput = colorInput;
    this.containerHomeColor = containerHomeColor;
    this.iconColorBlack = iconColorBlack;
    this.backgroundFirst = backgroundFirst;
    this.backgroundSecond = backgroundSecond;
    this.backgroundThird = backgroundThird;
    this.letterColor = letterColor;
    this.colorTextInput = colorTextInput;
    this.textBlack = textBlack;
    this.textWhite = textWhite;
  }

  Color? errorColor;
  Color? desabilitedColor;
  Color? lineHigherColor;
  Color? lineHigherTextColor;
  Color? secondPrincipalColor;
  Color? buttonConfig;
  Color? buttonDesabilited;
  Color? lineContainerContactColor;
  Color? lineContactColor;
  Color? colorInput;
  Color? containerHomeColor;
  Color? iconColorBlack;
  Color? backgroundFirst;
  Color? backgroundSecond;
  Color? backgroundThird;
  Color? letterColor;
  Color? colorTextInput;
  Color? textBlack;
  Color? textWhite;
}
